import { useState, useEffect } from "react";
import Modal, { ModalBody, ModalFooter } from '../Modal'
import PropTypes from 'prop-types';

// Components
import Button, { SecondaryButton } from '../Button';

// Services
import { updateSubscriber } from "../../services/subscriber";

const SubscriberStatusModal = (props) => {
  const { isOpen, onSuccess, onClose, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false)
  const [errors, setErrors] = useState([]) // State variable for errors

  const onUpdate = () => {
    const payload = {
      status: status === 'active' ? 'inactive' : 'active'
    }

    setIsDeleting(true)
    updateSubscriber(subscriberId, payload)
    .then(() => {
      onSuccess()
    })
    .catch((payload) => {
      const errorMessages = payload?.response?.data?.errors || ['Something went wrong']
      setErrors(errorMessages)
      console.error(errorMessages)
    })
    .finally(() => {
      setIsDeleting(false)
    })
  }

  useEffect(() => {
    // Reset the form fields when the modal opens
    if (isOpen) {
      setErrors([])
    }
  }, [isOpen])

  const modalTitleText = status === 'active' ?
    "Unsubscribe" : "Resubscribe"
  const messageBodyText = status === 'active' ?
    "Are you sure you'd like to unsubscribe this subscriber?" :
    "Are you sure you'd like to resubscribe this subscriber?"
  const buttonText = status === 'active' ?
    "Unsubscribe" : "Resubscribe"

  return (
    <Modal modalTitle={modalTitleText} showModal={isOpen} onCloseModal={onClose}>
      <>
        <ModalBody>
          {/* Display errors in a message box */}
          {errors.length > 0 && (
              <div className="bg-red-100 text-red-500 p-4 mb-4">
                {errors.map((error, index) => (
                    <p key={index}>{error}</p>
                ))}
              </div>
          )}
          {messageBodyText}
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
            onClick={onClose}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isDeleting}
            onClick={onUpdate}
          >
            {buttonText}
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
};

SubscriberStatusModal.propTypes = {
  isOpen: PropTypes.bool,
  onClose: PropTypes.func,
  onSuccess: PropTypes.func,
  subscriberId: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  status: PropTypes.string
}

export default SubscriberStatusModal;
