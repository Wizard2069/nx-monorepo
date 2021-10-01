import {
  MDBBtn,
  MDBCard,
  MDBCardBody,
  MDBCardImage,
  MDBCardText,
  MDBCardTitle,
  MDBSpinner,
  MDBCol,
} from 'mdbreact';
import {
  useAddPostMutation,
  useDeletePostMutation,
  useGetPostsQuery,
  usePrefetch,
} from '@htcompany/nx-react-example-data-access-post';
import { SyntheticEvent, useCallback, useEffect, useState } from 'react';
import { PageData, Pagination } from '@htcompany/shared-react-ui-pagination';
import * as faker from 'faker';

import './Post.module.scss';

/* eslint-disable-next-line */
export interface PostProps {}

export const Post = (props: PostProps) => {
  const [page, setPage] = useState(1);
  const {
    data: posts,
    error: getPostsError,
    isLoading,
  } = useGetPostsQuery(page);
  const [addPost, { isLoading: isUpdating }] = useAddPostMutation();
  const [deletePost] = useDeletePostMutation();
  const prefetchPage = usePrefetch('getPosts');

  const prefetchNext = useCallback(() => {
    prefetchPage(page + 1);
  }, [prefetchPage, page]);

  useEffect(() => {
    if (posts && posts.total_pages) {
      if (page >= posts.total_pages) {
        return;
      }
      prefetchNext();
    }
  }, [page, posts, prefetchNext]);

  const handleOnChangePage = (data: PageData) => {
    setPage(data.page);
  };

  const handleAddPost = async (e: SyntheticEvent) => {
    await addPost({
      image: faker.image.imageUrl(),
      title: faker.lorem.words(),
      content: faker.lorem.paragraph(),
    });
  };

  const handleDeletePost = async (id: string) => {
    await deletePost(id);
  };

  return (
    <>
      {getPostsError ? (
        <p style={{ color: 'red' }}>An error occurred</p>
      ) : isLoading ? (
        <MDBCol className="d-flex justify-content-center align-items-center">
          <MDBSpinner />
        </MDBCol>
      ) : (
        posts?.data?.map((post) => (
          <MDBCol md="4" key={post.id}>
            <MDBCard className="mt-md-5">
              <MDBCardImage className="img-fluid" src={post.image} waves />
              <MDBCardBody>
                <MDBCardTitle>{post.title}</MDBCardTitle>
                <MDBCardText>{post.content.substr(0, 100) + '...'}</MDBCardText>
                <MDBBtn
                  color="danger"
                  onClick={() => handleDeletePost(post.id)}
                >
                  Delete
                </MDBBtn>
              </MDBCardBody>
            </MDBCard>
          </MDBCol>
        ))
      )}

      {posts?.total && posts?.total_pages && (
        <MDBCol size="12">
          <Pagination
            totalElements={posts?.total}
            totalPages={posts?.total_pages}
            onChangePage={handleOnChangePage}
          />
        </MDBCol>
      )}

      <MDBCol
        size="12"
        className="d-flex justify-content-center align-items-center my-5"
      >
        <MDBBtn
          color="success"
          className="d-flex justify-content-center align-items-center"
          onClick={handleAddPost}
        >
          {isUpdating ? (
            <div className="spinner-border spinner-border-sm" role="status">
              <span className="sr-only">Loading...</span>
            </div>
          ) : (
            'Add'
          )}
        </MDBBtn>
      </MDBCol>
    </>
  );
};

export default Post;
