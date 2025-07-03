// Menu com opção de continuar se houver save
if (save_exists()) {
    menu_inicial = ["Continuar", "Novo Jogo", "Conquistas", "Opções", "Sair"];
} else {
    menu_inicial = ["Novo Jogo", "Conquistas", "Opções", "Sair"];
}
esc = [];
for (var i = 0; i < array_length(menu_inicial); i++) {
    esc[i] = 1;
}
global.musica_menu_id = audio_play_sound(som_menu_tema, 1, true);
audio_sound_gain(global.musica_menu_id, global.volume_musica, 0);

// Variáveis do popup de confirmação
popup_novo_jogo_ativo = false;
popup_novo_jogo_alpha = 0;
popup_novo_jogo_y_offset = 50;
popup_novo_jogo_escalas = [1, 1];