import { compare } from "bcryptjs";
import prismaClient from "../prisma";

interface AuthRequest {
    email: string;
    password: string;
}

class AuthUserService {
    async execute({email, password}: AuthRequest) {
        const user = await prismaClient.usuario.findFirst({
            where: {
                email: email
            }
        })

        if(!user) {
            throw new Error("Usuário ou Senha inválido!")
        }

        const passwordMatch = await compare(password, user.password)
    
        if(!passwordMatch) {
            throw new Error("Usuário ou Senha inválido!")
        }
    }
}

export {AuthUserService}