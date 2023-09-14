import React, { useState, useEffect, useCallback } from 'react';
import axios from 'axios';

function App() {
  const [page, setPage] = useState(1);
  const [perPage, setPerPage] = useState(25);
  const [showAddModal, setShowAddModal] = useState(false);
  const [subscribers, setSubscribers] = useState([]);
  const [pagination, setPagination] = useState({});
  const [isLoading, setIsLoading] = useState(false);

  const fetchSubscribers = useCallback(async () => {
    setIsLoading(true);
    try {
      const response = await axios.get('/api/subscribers', {
        params: {
          page,
          per_page: perPage,
        },
      });
      setSubscribers(response.data.subscribers);
      setPagination(response.data.pagination);
    } catch (error) {
      console.error('Error fetching subscribers:', error);
    } finally {
      setIsLoading(false);
    }
  }, [page, perPage]);

  const addSubscriber = async (newSubscriber) => {
    try {
      await axios.post('/api/subscribers/create', newSubscriber);
      fetchSubscribers();
    } catch (error) {
      console.error('Error adding subscriber:', error);
    }
  };

  const updateSubscriberStatus = async (subscriberId, status) => {
    try {
      await axios.put(`/api/subscribers/${subscriberId}`, { status });
      fetchSubscribers();
    } catch (error) {
      console.error('Error updating subscriber:', error);
    }
  };

  useEffect(() => {
    fetchSubscribers();
  }, [fetchSubscribers]);

  return (
    <div>
      <h1>Subscribers</h1>
      <button onClick={() => setShowAddModal(true)}>Add Subscriber</button>
      {showAddModal && (
        <div>
          {/* Add Subscriber Modal */}
          {/* Implement your own logic here to add a subscriber */}
          <button onClick={() => addSubscriber({/* your new subscriber data */})}>Add</button>
          <button onClick={() => setShowAddModal(false)}>Cancel</button>
        </div>
      )}
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {subscribers.map((subscriber) => (
            <tr key={subscriber.id}>
              <td>{subscriber.id}</td>
              <td>{subscriber.name}</td>
              <td>{subscriber.email}</td>
              <td>{subscriber.status}</td>
              <td>
                <button onClick={() => {
                  updateSubscriberStatus(subscriber.id, /* new status */);
                }}>
                  Update Status
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <div>
        {/* Pagination */}
        <button disabled={page === 1} onClick={() => setPage(page - 1)}>Previous</button>
        <span>Page {page} of {Math.ceil(pagination.total / perPage)}</span>
        <button disabled={page >= Math.ceil(pagination.total / perPage)} onClick={() => setPage(page + 1)}>Next</button>
      </div>
    </div>
  );
}

export default App;
