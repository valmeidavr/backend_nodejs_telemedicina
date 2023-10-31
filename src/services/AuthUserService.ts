import { compare } from "bcryptjs";
import prismaClient from "../prisma";
import { sign } from 'jsonwebtoken';

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

        const token = sign(
            {
                nome: user.nome,
                email: user.email
            },
            process.env.JWT_SECRET,
            {
                subject: user.id,
                expiresIn: '30d'
            }
        )

        return {
            id: user.id,
            nome: user.nome,
            email: user.email,
            grupo: user.grupo,
            token: token
        }
    }
}

export {AuthUserService}