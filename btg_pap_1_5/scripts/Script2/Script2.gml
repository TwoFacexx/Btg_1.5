function screenshake(_treme)
{
    // Verifica se já existe uma instância de screenshake para evitar múltiplas instâncias
    if (!instance_exists(obj_screenshake))
    {
        var _shake_instance = instance_create_layer(0, 0, "Instances", obj_screenshake);
        _shake_instance.shake = _treme;
    }
    else
    {
        // Se já existe, pode optar por aumentar a força do shake existente
        obj_screenshake.shake = max(obj_screenshake.shake, _treme);
    }
}
