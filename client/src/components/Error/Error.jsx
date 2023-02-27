import React from 'react'

const Error = function ({ errors }) {
  return (
    <div className="block text-red-700 text-sm font-bold mb-2">
      {errors.map((error, index) => <div key={index}>{error}</div>)}
    </div>
  )
}

export default Error
