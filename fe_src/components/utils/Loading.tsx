import { Container, Spinner } from 'react-bootstrap';

const Loading = () => (
  <Container className="spinner-container">
    <Spinner animation="border" role="status" variant="secondary">
      <span className="visually-hidden">Loading...</span>
    </Spinner>
  </Container>
);

export default Loading;
