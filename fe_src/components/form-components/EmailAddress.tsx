import { Button, Form, InputGroup } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface EmailAddressProps {
  label?: string;
  emailAddress: string;
  setEmailAddress: React.Dispatch<React.SetStateAction<string>>;
  feedback: boolean;
  emailAddressError: string;
  updatable?: boolean;
  updateEmailAddress?: () => void;
}

const EmailAddress = ({
  label = 'Email cím',
  emailAddress,
  setEmailAddress,
  feedback,
  emailAddressError,
  updatable = false,
  updateEmailAddress,
}: EmailAddressProps) => {
  const onEmailAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailAddress(e.target.value);
  };

  return (
    <Form.Group controlId={`email-${uuidv4()}`}>
      <Form.Label>{label}</Form.Label>
      <InputGroup className="mb-3">
        <Form.Control
          isInvalid={!!emailAddressError}
          onInput={onEmailAddressChange}
          required
          value={emailAddress}
        />
        {updatable && (
          <Button
            id={`emailUpdateButton-${uuidv4()}`}
            onClick={updateEmailAddress}
            variant="primary"
          >
            Mentés
          </Button>
        )}
        {feedback && (
        <Form.Control.Feedback type="invalid">
          {emailAddressError}
        </Form.Control.Feedback>
        )}
      </InputGroup>
    </Form.Group>
  );
};

export default EmailAddress;
