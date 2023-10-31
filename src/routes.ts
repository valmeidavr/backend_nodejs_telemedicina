import {Router } from 'express';
import { AuthUserController } from './controllers/user/AuthUserController';
import { CreateUserController } from './controllers/user/CreateUserController';
import { DetailtUserController } from './controllers/user/DetailUserController';
import { isAuthenticated } from './middlewares/isAuthenticated';

const router = Router();

router.post('/users', new CreateUserController().handle)
router.post('/auth', new AuthUserController().handle)
router.get('/me', isAuthenticated, new DetailtUserController().handle)

export { router };