namespace * barramento

struct Message {
    1: i64 id,
    2: string text
}

service BarramentoService {
    Message hello(1: Message m)
}
