import { useState, useEffect, useCallback } from "react";
// import { useQueryParam, NumberParam, withDefault } from "use-query-params";

import { SecondaryButton } from "./components/Button";
import AddSubscriberModal from "./components/AddSubscriberModal";
// import SubscriberStatusModal from "./components/SubscriberStatusModal";
import SubscriberTable from "./components/SubscriberTable";
import TablePagination from "./components/TablePagination";
import LoadingSpinner from "./components/LoadingSpinner";
import store from "./store";

// Styles
import "./App.css";

function App() {
  const [showAddModal, setShowAddModal] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const fetchSubscribers = useCallback(async () => {
    setIsLoading(true);
    try {
      await store.subscribers.fetch({
        page: 1,
        perPage: 25,
      });
    } catch (error) {
      // handle error
    }

    setIsLoading(false);
  }, []);

  useEffect(() => {
    fetchSubscribers();
  }, [fetchSubscribers]);

  // const onPageSelected = (page) => {
  //   setPage(page);
  // };

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
          <TablePagination
            pagination={store.subscribers.pagination}
            // onPageSelected={onPageSelected}
          />
        </div>
      </main>
    </div>
  );
}

export default App;
