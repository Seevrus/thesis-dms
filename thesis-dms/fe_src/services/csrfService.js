import axios from 'axios';

const fetchCsrfToken = async () => {
  const response = await axios.get('/api/auth/csrf.php');
  return response.data.csrfToken;
};

const setCsrfToken = (token) => {
  if (token) {
    axios.defaults.headers.post['X-CSRF-Token'] = token;
    axios.defaults.headers.delete['X-CSRF-Token'] = token;
  } else {
    delete axios.defaults.headers.post['X-CSRF-Token'];
    delete axios.defaults.headers.delete['X-CSRF-Token'];
  }
};

const setupCsrfToken = async () => {
  const csrfToken = await fetchCsrfToken();
  setCsrfToken(csrfToken);
};

export default setupCsrfToken;
