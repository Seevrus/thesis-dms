import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableUserActivity = loadable(() => import('./ActivityStatistics'), {
  fallback: <Loading />,
});

export default LoadableUserActivity;
