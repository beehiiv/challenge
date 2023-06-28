const axios = require('axios');

export const getSubscribers = (params = {}) => {
  const headers = {
    'Content-Type': 'application/json'
  }

  return axios.get('/api/subscribers', {
    params: params,
    headers: headers
  })
}

export const createSubscriber = (payload = {}) => {
  const headers = {
    'Content-Type': 'application/json'
  }

  return axios.post('/api/subscribers', payload, {
    headers: headers
  })
}

export const updateSubscriber = (subscriberId, payload = {}) => {
  const headers = {
    'Content-Type': 'application/json'
  }

  return axios.patch(`/api/subscribers/${subscriberId}`, payload, {
    headers: headers
  })
}
