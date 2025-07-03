if (keyboard_check_pressed(vk_enter)) {
    room_goto(rm_menu);
}

if (keyboard_check_pressed(ord("T"))) {
    show_debug_message("Tentando adicionar conquista teste manualmente...");
    var resultado = save_add_achievement("primeiro_porco");
    show_debug_message("Resultado: " + string(resultado));
    
    // Verificar se foi adicionada
    var tem = save_tem_conquista("primeiro_porco");
    show_debug_message("Tem conquista agora? " + string(tem));
}
// Teste manual - pressione I para INICIALIZAR
if (keyboard_check_pressed(ord("I"))) {
    show_debug_message("=== FORÇANDO INICIALIZAÇÃO ===");
    
    // Limpar save_data atual
    ds_map_clear(global.save_data);
    
    // Chamar inicialização
    save_system_init();
    
    // Verificar se funcionou
    var jogador = global.save_data[? "jogador"];
    show_debug_message("Jogador criado: " + string(jogador != undefined));
    
    if (jogador != undefined) {
        var conquistas = jogador[? "conquistas"];
        show_debug_message("Lista conquistas criada: " + string(conquistas != undefined));
    }
}