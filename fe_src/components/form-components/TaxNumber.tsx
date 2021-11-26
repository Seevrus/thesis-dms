import { Col, Form, Row } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface TaxNumberProps {
  disabled?: boolean;
  taxNumber: number | string;
  setTaxNumber?: React.Dispatch<React.SetStateAction<string>>;
  taxNumberError?: string;
  feedback: boolean;
}

const TaxNumber = ({
  disabled = false,
  taxNumber,
  setTaxNumber,
  taxNumberError,
  feedback,
}: TaxNumberProps) => {
  const onTaxNumberChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const taxNumberInput = e.target.value;
    setTaxNumber(taxNumberInput);
  };

  return (
    <Row>
      <Col md="12">
        <Form.Group controlId={`taxNumber-${uuidv4()}`}>
          <Form.Label>Adóazonosító jel</Form.Label>
          <Form.Control
            disabled={disabled}
            isInvalid={!!taxNumberError}
            onChange={!disabled ? onTaxNumberChange : undefined}
            required
            value={taxNumber}
          />
          {feedback && (
          <Form.Control.Feedback type="invalid">
            {taxNumberError}
          </Form.Control.Feedback>
          )}
        </Form.Group>
      </Col>
    </Row>
  );
};

export default TaxNumber;
