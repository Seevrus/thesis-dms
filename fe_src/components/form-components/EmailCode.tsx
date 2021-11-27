import { Col, Form, Row } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface EmailCodeProps {
  emailCode: string;
  setEmailCode: React.Dispatch<React.SetStateAction<string>>;
  emailCodeError: string;
}

const EmailCode = ({
  emailCode,
  setEmailCode,
  emailCodeError,
}: EmailCodeProps) => {
  const onEmailCodeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmailCode(e.target.value);
  };

  return (
    <Row>
      <Col className="md-12">
        <Form.Group className="mb-3" controlId={`code-${uuidv4()}`}>
          <Form.Label>Email kód</Form.Label>
          <Form.Control
            isInvalid={!!emailCodeError}
            onInput={onEmailCodeChange}
            required
            value={emailCode}
          />
          <Form.Control.Feedback type="invalid">{emailCodeError}</Form.Control.Feedback>
        </Form.Group>
      </Col>
    </Row>
  );
};

export default EmailCode;
