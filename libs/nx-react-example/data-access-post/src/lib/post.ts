import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';
import { Post, ListResponse } from './types';

export const postApi = createApi({
  reducerPath: 'postApi',
  baseQuery: fetchBaseQuery({
    baseUrl: '/',
  }),
  tagTypes: ['Post'],
  endpoints: (builder) => ({
    getPosts: builder.query<ListResponse<Post>, number>({
      query: (page = 1) => `posts?page=${page}`,
      providesTags: (result, err, arg) =>
        result
          ? [
              ...result.data.map(({ id }) => ({ type: 'Post' as const, id })),
              { type: 'Post', id: 'LIST' },
            ]
          : [{ type: 'Post', id: 'LIST' }],
    }),
    getPost: builder.query<Post, string>({
      query: (id) => `posts/${id}`,
      providesTags: (result, error, arg) => [{ type: 'Post', id: arg }],
    }),
    addPost: builder.mutation<Post, Omit<Post, 'id'>>({
      query: (body) => ({
        url: `posts`,
        method: 'POST',
        body,
      }),
      invalidatesTags: [{ type: 'Post', id: 'LIST' }],
    }),
    editPost: builder.mutation<Post, Partial<Post> & Pick<Post, 'id'>>({
      query: (body) => ({
        url: `post/${body.id}`,
        method: 'PATCH',
        body,
      }),
      invalidatesTags: (result, error, arg) => [{ type: 'Post', id: arg.id }],
    }),
    deletePost: builder.mutation<Post, string>({
      query: (id) => ({
        url: `posts/${id}`,
        method: 'DELETE',
      }),
      invalidatesTags: [{ type: 'Post', id: 'LIST' }],
    }),
  }),
});

export const {
  useGetPostsQuery,
  useGetPostQuery,
  useAddPostMutation,
  useEditPostMutation,
  useDeletePostMutation,
  usePrefetch,
} = postApi;
