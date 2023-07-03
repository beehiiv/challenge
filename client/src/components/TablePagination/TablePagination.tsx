import React from "react";
import cx from "classnames";
import { Pagination } from "../../global.d";

export interface Props {
  className?: string;
  onPageSelected(page: number): void;
  pagination: Pagination;
  insideCard?: boolean;
}

const leftChevron = (
  <svg
    className="h-5 w-5"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 20 20"
    fill="currentColor"
    aria-hidden="true"
  >
    <path
      fillRule="evenodd"
      d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
      clipRule="evenodd"
    />
  </svg>
);

const rightChevron = (
  <svg
    className="h-5 w-5"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 20 20"
    fill="currentColor"
    aria-hidden="true"
  >
    <path
      fillRule="evenodd"
      d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
      clipRule="evenodd"
    />
  </svg>
);

const TablePagination = ({
  pagination,
  insideCard = false,
  onPageSelected,
}: Props) => {
  const renderLinks = () => {
    const page = pagination?.page;
    const totalPages = pagination?.total_pages;
    const maxLinks = totalPages > 5 ? 5 : totalPages;

    let startNum = 1;
    if (page > 2 && totalPages > 5) {
      startNum = page - 2;
    }

    const links = [];

    const currentClassName =
      "z-10 bg-primary-gold-50 border-primary-gold-500 text-primary-gold-600 relative inline-flex items-center px-4 py-2 border text-sm font-medium";
    const regularClassName =
      "bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium";

    for (let i = startNum; i < startNum + maxLinks; i++) {
      if (i <= totalPages) {
        links.push(
          <button
            key={`page-${i}`}
            aria-current={i === page}
            className={i === page ? currentClassName : regularClassName}
            onClick={() => onPageSelected(i)}
            data-testid="tablePaginationPageButton"
          >
            {i}
          </button>
        );
      }
    }

    return <React.Fragment>{links}</React.Fragment>;
  };

  const renderPagination = () => {
    const total = pagination?.total;
    const page = pagination?.page;
    const totalPages = pagination?.total_pages;
    const nextPage = page + 1 > totalPages ? totalPages : page + 1;
    const prevPage = page - 1 < 1 ? 1 : page - 1;

    return (
      <div
        className={cx(
          "py-3 flex items-center justify-between",
          insideCard ? "bg-white border-t border-gray-200" : ""
        )}
        data-testid="tablePaginationComponent"
      >
        <div className="flex-1 flex justify-between sm:hidden">
          <button
            className="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
            onClick={() => onPageSelected(prevPage)}
          >
            Previous
          </button>
          <button
            className="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50"
            onClick={() => onPageSelected(nextPage)}
          >
            Next
          </button>
        </div>
        <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
          <div>
            <p className="text-sm text-gray-700">
              <span className="font-medium">{total}&nbsp;</span>
              results
            </p>
          </div>
          <div>
            <nav
              className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
              aria-label="Pagination"
            >
              <button
                className="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50"
                onClick={() => onPageSelected(prevPage)}
              >
                <span className="sr-only">Previous</span>
                {leftChevron}
              </button>
              {renderLinks()}
              <button
                className="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50"
                onClick={() => onPageSelected(nextPage)}
              >
                <span className="sr-only">Next</span>
                {rightChevron}
              </button>
            </nav>
          </div>
        </div>
      </div>
    );
  };

  return renderPagination();
};

export default TablePagination;
