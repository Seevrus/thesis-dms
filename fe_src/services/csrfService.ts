import axios from 'axios';

const fetchCsrfToken = async () => {
  const response = await axios.get(`${import.meta.env.VITE_API_URL}/auth/csrf.php`);
  return response.data.csrfToken;
};

const setCsrfToken = (token: string) => {
  if (token) {
    axios.defaults.headers.get['X-CSRF-Token'] = token;
    axios.defaults.headers.head['X-CSRF-Token'] = token;
    axios.defaults.headers.post['X-CSRF-Token'] = token;
  } else {
    delete axios.defaults.headers.get['X-CSRF-Token'];
    delete axios.defaults.headers.head['X-CSRF-Token'];
    delete axios.defaults.headers.post['X-CSRF-Token'];
  }
};

const setupCsrfToken = async () => {
  const csrfToken = await fetchCsrfToken();
  setCsrfToken(csrfToken);
};

export default setupCsrfToken;
