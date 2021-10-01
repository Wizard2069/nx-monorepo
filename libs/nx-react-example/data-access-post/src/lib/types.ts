export interface Post {
  id: string;
  title: string;
  content: string;
  image: string;
}

export interface ListResponse<T> {
  page: number;
  per_page: number;
  total: number;
  total_pages: number;
  data: T[];
}
