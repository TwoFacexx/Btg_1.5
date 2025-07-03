function screenshake(_treme)
{
    // Verifica se já existe uma instância de screenshake para evitar múltiplas instâncias
    // Checks if a screenshake instance already exists to avoid duplicates
    if (!instance_exists(obj_screenshake))
    {
        // Cria uma nova instância do objeto de screenshake na layer "Instances"
        // Creates a new instance of the screenshake object on the "Instances" layer
        var _shake_instance = instance_create_layer(0, 0, "Instances", obj_screenshake);
        
        // Define a intensidade do tremor (shake)
        // Sets the intensity of the shake effect
        _shake_instance.shake = _treme;
    }
    else
    {
        // Se já existe, pode optar por aumentar a força do shake existente
        // If it already exists, optionally increase the shake intensity if the new value is higher
        obj_screenshake.shake = max(obj_screenshake.shake, _treme);
    }
}

function mostrar_conquista(_nome) {
    // Cria um popup para mostrar a conquista desbloqueada
    // Creates a popup instance to show the unlocked achievement
    var _popup = instance_create_layer(0, 0, "Instances", obj_conquista_popup);
    
    // Define o texto do popup com o nome da conquista
    // Sets the popup text with the achievement name
    _popup.texto = "Conquista: " + _nome;
}

function tocar_som(_som, _prioridade = 5, _loop = false) {
    // Toca um som com a prioridade e se deve repetir (loop) ou não
    // Plays a sound with given priority and loop option
    
    var _id = audio_play_sound(_som, _prioridade, _loop);
    
    // Ajusta o volume do som com base na configuração global do volume SFX
    // Adjusts sound volume according to global SFX volume setting
    audio_sound_gain(_id, global.volume_sfx, 0);
    
    // Retorna o id do som tocado para controle posterior, se necessário
    // Returns the id of the played sound for possible later control
    return _id;
}
