import { factory, primaryKey } from '@mswjs/data';
import { Post } from '@htcompany/nx-react-example-data-access-post';
import { nanoid } from '@reduxjs/toolkit';
import faker from 'faker';
import { rest } from 'msw';

const db = factory({
  post: {
    id: primaryKey(String),
    title: String,
    content: String,
    image: String,
  },
});

const createPostData = (): Post => {
  return {
    id: nanoid(),
    title: faker.lorem.words(),
    content: faker.lorem.paragraph(),
    image: faker.image.imageUrl(),
  };
};

[...new Array(10000)].forEach((_) => db.post.create(createPostData()));

export const handlers = [
  rest.get('/posts', (req, res, ctx) => {
    const page = (req.url.searchParams.get('page') || 1) as number;
    const per_page = (req.url.searchParams.get('per_page') || 10) as number;
    const data = db.post.findMany({
      take: per_page,
      skip: Math.max(per_page * (page - 1), 0),
    });

    return res(
      ctx.json({
        data,
        page,
        total_pages: Math.ceil(db.post.count() / per_page),
        total: db.post.count(),
      })
    );
  }),
  rest.post<Omit<Post, 'id'>>('/posts', (req, res, ctx) => {
    const { title, content, image } = req.body;

    const newPost = db.post.create({
      id: nanoid(),
      title,
      content,
      image,
    });

    return res(ctx.json(newPost));
  }),
  ...db.post.toHandlers('rest'),
] as const;
