import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableLoginForm = loadable(() => import('./LoginForm'), {
  fallback: <Loading />,
});

export default LoadableLoginForm;
