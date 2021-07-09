import axios from 'axios';

const loginService = async (taxNumber, loginPwd) => {
  const credentials = { taxNumber, password: loginPwd };
  try {
    const response = await axios.post('/api/user/login.php', credentials);
    return response.data;
  } catch (e) {
    return e.response.data;
  }
};

export default loginService;
