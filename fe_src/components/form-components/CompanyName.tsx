import { Form } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface CompanyNameProps {
  value: string;
}

const CompanyName = ({ value }: CompanyNameProps) => (
  <Form.Group className="mb-3" controlId={`companyName-${uuidv4()}`}>
    <Form.Label>Cég</Form.Label>
    <Form.Control disabled value={value} />
  </Form.Group>
);

export default CompanyName;
