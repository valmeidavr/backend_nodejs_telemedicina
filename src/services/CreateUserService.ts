import prismaClient from '../prisma'

interface UserRequest{
    nome: string;
    email: string;
    password: string;
    celular: string,
    cpf: string
}

class CreateUserService {
    async execute({nome, email, password, celular, cpf}: UserRequest){
        if(!email) {
            throw new Error("E-mail incorreto!");
        }

        const userAlreadyExists = await prismaClient.usuario.findFirst({
            where: {
                email: email
            }
        })

        if(!userAlreadyExists) {
            throw new Error("Usuário já existe!");
        }

        const user = await prismaClient.usuario.create({
            data:{
                nome: nome,
                email: email,
                password: password,
                celular: celular,
                cpf: cpf
            },
            select: {
                id: true,
                nome: true,
                email: true,
                celular: true,
                cpf: true,
                grupo: true
            }
        })
        return user;
    }
}

export { CreateUserService } 