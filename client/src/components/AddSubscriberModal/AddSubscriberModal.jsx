import { useEffect, useState } from "react";
import PropTypes from 'prop-types'
import Button, { SecondaryButton } from '../Button'
import Modal, { ModalBody, ModalFooter } from '../Modal'

import { createSubscriber } from "../../services/subscriber";

const AddSubscriberModal = (props) => {
  const { isOpen, onClose, onSuccess } = props
  const [isSaving, setIsSaving] = useState(false)
  const [email, setEmail] = useState('')
  const [name, setName] = useState('')
  const [error, setError] = useState('') // Added error state

  // Added useEffect to reset the form fields when the modal is opened
  useEffect(() => {
    if (isOpen) {
      setEmail('')
      setName('')
      setError('')
    }
  }, [isOpen])

  const handleChange = (e) => {
    const { target: { name, value }} = e

    if (name === 'email') {
      setEmail(value)
    } else if (name === 'name') {
      setName(value)
    }
  }

  const onSubmit = () => {
    const payload = {
      email,
      name
    }

    setIsSaving(true)
    createSubscriber(payload)
    .then(() => {
      onSuccess()
    })
    .catch((payload) => {
      const errorMsg = payload?.response?.data?.message || 'Something went wrong'
      setError(errorMsg) // Set the error message
      console.error(errorMsg)
    })
    .finally(() => {
      setIsSaving(false)
    })
  }

  return (
    <Modal modalTitle="Add Subscriber" showModal={isOpen} onCloseModal={onClose}>
      <>
        <ModalBody>
          {error && <div className="text-red-500 mb-2">{error}</div>} {/* Display the error message */}
          <form className="my-4 text-blueGray-500 text-lg leading-relaxed">
            {/* Rest of the form remains the same */}
          </form>
        </ModalBody>
        <ModalFooter>
          {/* Rest of the footer remains the same */}
        </ModalFooter>
      </>
    </Modal>
  );
}

AddSubscriberModal.propTypes = {
  isOpen: PropTypes.bool, 
  onClose: PropTypes.func,
  onSuccess: PropTypes.func
}

export default AddSubscriberModal
