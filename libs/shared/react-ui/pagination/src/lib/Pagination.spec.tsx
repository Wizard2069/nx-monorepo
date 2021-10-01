import { render } from '@testing-library/react';

import Pagination from './Pagination';

describe('Pagination', () => {
  it('should render successfully', () => {
    const { baseElement } = render(
      <Pagination
        totalElements={1}
        currentPage={1}
        totalPages={1}
        onChangePage={(data) => data}
      />
    );
    expect(baseElement).toBeTruthy();
  });
});
