import { Form } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';

interface UserRealNameProps {
  value: string;
}

const UserRealName = ({ value }: UserRealNameProps) => (
  <Form.Group className="mb-3" controlId={`userRealName-${uuidv4()}`}>
    <Form.Label>Név</Form.Label>
    <Form.Control disabled value={value} />
  </Form.Group>
);

export default UserRealName;
