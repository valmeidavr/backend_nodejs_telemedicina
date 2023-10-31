import { Request, response, Response } from "express";
import { CreateUserService } from "../../services/user/CreateUserService";

class CreateUserController {
    async handle(req: Request, res: Response){
        const {nome, email, password, celular, cpf} = req.body;

        const createUserService = new CreateUserService();

        const user = createUserService.execute({
            nome, 
            email,
            password,
            celular,
            cpf
        });

        return response.json(user);
    }
}

export { CreateUserController }