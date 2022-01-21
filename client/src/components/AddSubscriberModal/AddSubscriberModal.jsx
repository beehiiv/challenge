import { useState } from "react";
import PropTypes from 'prop-types'
import Button, { SecondaryButton } from '../Button'
import Modal, { ModalBody, ModalFooter } from '../Modal'

import { createSubscriber } from "../../services/subscriber";

const AddSubscriberModal = (props) => {
  const { isOpen, onClose, onSuccess, onError } = props
  const [isSaving, setIsSaving] = useState(false)
  const [email, setEmail] = useState('')
  const [name, setName] = useState('')
  const [errorText, setErrorText] = useState('')
  const [errorClass, setErrorClass] = useState('')

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
      const error = payload?.response?.data?.message || 'Something went wrong'
      setErrorText(error + "  Your email address is not correct.")
      setErrorClass("error")
      onError()
    })
    .finally(() => {
      setIsSaving(false)
    })
  }

  return (
    <Modal modalTitle="Add Subscriber" showModal={isOpen} onCloseModal={onClose}>
      <>
        <ModalBody>
          <form className="my-4 text-blueGray-500 text-lg leading-relaxed">
            <div className="mb-4">
              <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="email">
                Email*
              </label>
              <input
                className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                name="email"
                type="email"
                placeholder="rickc137@citadel.com"
                onChange={handleChange}
                value={email}
              />
              <div className="error">
                {errorText}
              </div>
            </div>
            <div className="mb-4">
              <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="name">
                Name
              </label>
              <input
                className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                name="name"
                type="text"
                placeholder="Rick Sanchez"
                onChange={handleChange}
                value={name}
              />
            </div>
          </form>
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1"
            type="button"
            onClick={onClose}
          >
            Cancel
          </SecondaryButton>
          <Button
            className="bg-blue-500 hover:bg-blue-700 text-white font-bold uppercase"
            type="button"
            onClick={onSubmit}
            loading={isSaving}
          >
            Add Subscriber
          </Button>
        </ModalFooter>
      </>
    </Modal>
  );
}

AddSubscriberModal.propTypes = {
  isOpen: PropTypes.bool, 
  onClose: PropTypes.func,
  onSuccess: PropTypes.func,
  onError: PropTypes.func
}

export default AddSubscriberModal