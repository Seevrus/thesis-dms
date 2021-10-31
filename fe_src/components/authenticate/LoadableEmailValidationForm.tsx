import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const EmailValidationForm = loadable(() => import('./EmailValidationForm'), {
  fallback: <Loading />,
});

export default EmailValidationForm;
