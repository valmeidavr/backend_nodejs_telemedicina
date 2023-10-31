import {Router } from 'express';
import { AuthUserController } from './controllers/user/AuthUserController';
import { CreateUserController } from './controllers/user/CreateUserController';

const router = Router();

router.post('/users', new CreateUserController().handle)
router.post('/auth', new AuthUserController().handle)

export { router };