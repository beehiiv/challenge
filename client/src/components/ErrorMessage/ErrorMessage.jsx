import React from 'react';

const ErrorMessage = ({ errors }) => {
    if (errors.length === 0) {
        return null;
    }

    return (
        <div className="bg-red-100 text-red-500 p-4 mb-4">
            {errors.map((error, index) => (
                <p key={index}>{error}</p>
            ))}
        </div>
    );
};

export default ErrorMessage;
