import { Navigate } from 'react-router-dom';
import { useAuth } from './AuthContext'; // Adjust the import path as necessary

const ProtectedRoute = ({ element }) => {
  const { isAuthenticated } = useAuth();

  return isAuthenticated ? element : <Navigate to="/login" />;
};
