import { Container, Spinner } from 'react-bootstrap';

import './spinner.css';

const Loading = () => (
  <Container className="d-flex justify-content-center spinner-container">
    <Spinner animation="border" role="status" variant="secondary" />
  </Container>
);

export default Loading;
