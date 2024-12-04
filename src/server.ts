import Fastify from 'fastify';
import { WebSocketServer, WebSocket } from 'ws';
import cors from '@fastify/cors';

const app = Fastify();

const wss = new WebSocketServer({ noServer: true });
const clients = new Set<WebSocket>();

app.ready((err) => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    
    app.server.on('upgrade', (request, socket, head) => {
        wss.handleUpgrade(request, socket, head, (ws) => {
            wss.emit('connection', ws, request);
        });
    });
});

app.register(cors, {
    origin: true
});

app.listen({ port: 3000 }, (err) => {
    if (err) {
        console.error(err);
        process.exit(1);
    }
    console.log('Servidor WebSocket em execução em http://127.0.0.1:3000');
});

wss.on('connection', (ws: WebSocket) => { 
    console.log('Cliente conectado via WebSocket');
    clients.add(ws); 

    ws.on('message', (message) => {
        console.log('Mensagem recebida:', message);

        for (const client of clients) {
            if (client !== ws && client.readyState === WebSocket.OPEN) {
                client.send(message);
            }
        }
    });

    ws.on('close', () => {
        console.log('Conexão fechada');
        clients.delete(ws);
    });

    ws.on('error', (error) => {
        console.error('Erro no WebSocket:', error);
    });
}); 