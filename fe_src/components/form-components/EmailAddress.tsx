import {
  Button,
  Col,
  Form,
  InputGroup,
  Row,
} from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface EmailAddressProps {
  label?: string;
  emailAddress: string;
  setEmailAddress: React.Dispatch<React.SetStateAction<string>>;
  feedback?: boolean;
  emailAddressError?: string;
  updatable?: boolean;
  updateEmailAddress?: () => void;
}

const EmailAddress = ({
  label = 'Email cím',
  emailAddress,
  setEmailAddress,
  feedback = false,
  emailAddressError,
  updatable = false,
  updateEmailAddress,
}: EmailAddressProps) => {
  const onEmailAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailAddress(e.target.value);
  };

  return (
    <Row>
      <Col md="12">
        <Form.Group controlId={`email-${uuidv4()}`}>
          <Form.Label>{label}</Form.Label>
          <InputGroup>
            <Form.Control
              isInvalid={!!emailAddressError}
              onInput={onEmailAddressChange}
              required
              value={emailAddress ?? ''}
            />
            {updatable && (
              <InputGroup.Append>
                <Button
                  id={`emailUpdateButton-${uuidv4()}`}
                  onClick={updateEmailAddress}
                  className="btn-fill"
                  variant="primary"
                >
                  Mentés
                </Button>
              </InputGroup.Append>
            )}
            {feedback && (
              <Form.Control.Feedback type="invalid">
                {emailAddressError}
              </Form.Control.Feedback>
            )}
          </InputGroup>
        </Form.Group>
      </Col>
    </Row>
  );
};

export default EmailAddress;
