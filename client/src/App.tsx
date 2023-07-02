import { useState, useEffect, useCallback, useRef } from "react";
// import { useQueryParam, NumberParam, withDefault } from "use-query-params";

import { SecondaryButton } from "./components/Button";
import AddSubscriberModal from "./components/AddSubscriberModal";
import SubscriberTable from "./components/SubscriberTable";
import TablePagination from "./components/TablePagination";
import LoadingSpinner from "./components/LoadingSpinner";
import store from "./store";

// Styles
import "./App.css";
import { PAGINATION_DEFAULT_PAGE, PAGINATION_ROWS_PER_PAGE } from "./constants";
import { NumberParam, useQueryParam, withDefault } from "use-query-params";

function App() {
  const [currentPage, setCurrentPage] = useQueryParam(
    "page",
    withDefault(NumberParam, PAGINATION_DEFAULT_PAGE)
  );
  const [showAddModal, setShowAddModal] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const fetchSubscribers = useCallback(
    async (page: number, perPage: number) => {
      setIsLoading(true);
      try {
        await store.subscribers.fetch({
          page,
          perPage,
        });
      } catch (error) {
        // handle error
      }

      setIsLoading(false);
    },
    []
  );

  // On Mount
  useEffect(() => {
    fetchSubscribers(currentPage, PAGINATION_ROWS_PER_PAGE);
  }, [currentPage]);

  const onPageSelected = (page: number) => {
    setCurrentPage(page);
  };

  const onOpenAddSubscriber = () => {
    setShowAddModal(true);
  };

  const onCloseAddSubscriberModal = () => {
    setShowAddModal(false);
  };

  const onSuccessAddSubscriber = () => {
    setShowAddModal(false);
  };

  return (
    <div
      className="min-h-screen bg-gray-100 text-gray-900"
      data-testid="appComponent"
    >
      <main className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 pt-4">
        <AddSubscriberModal
          isOpen={showAddModal}
          onClose={onCloseAddSubscriberModal}
          onSuccess={onSuccessAddSubscriber}
        />

        <div className="flex justify-between items-center">
          <h1 className="text-xl font-semibold flex items-center">
            {store.subscribers.pagination?.total} Subscribers{" "}
            {isLoading && <LoadingSpinner className="ml-4" />}
          </h1>
          <SecondaryButton
            onClick={onOpenAddSubscriber}
            data-testid="addSubscriberButtonComponent"
            className={undefined}
            loading={undefined}
            disabled={undefined}
          >
            Add Subscriber
          </SecondaryButton>
        </div>
        <div className="mt-6">
          {!isLoading && store.subscribers.items && (
            <SubscriberTable subscribers={store.subscribers} />
          )}
          {store.subscribers.pagination && (
            <TablePagination
              pagination={store.subscribers.pagination}
              onPageSelected={onPageSelected}
            />
          )}
        </div>
      </main>
    </div>
  );
}

export default App;
