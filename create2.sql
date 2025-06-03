CREATE TABLE LUGARES_GEOGRAFICOS(
    id_lugar_geografico numeric(3) PRIMARY KEY,
    nombre_lugar_geografico varchar(50) NOT NULL,
    tipo_lugar_geografico varchar(6) NOT NULL,
    id_padre_lugar_geografico numeric(3),

    constraint FK_padre_lugar_geografico FOREIGN KEY (id_padre_lugar_geografico) 
        references LUGARES_GEOGRAFICOS(id_lugar_geografico),

    constraint tipo_lugar_geografico check(tipo_lugar_geografico in ('pais','estado','ciudad'))
);

CREATE TABLE MUSEOS(
    id_museo numeric(3) PRIMARY KEY,
    nombre_museo varchar(50) NOT NULL,
    mision_museo varchar(200) NOT NULL,
    fecha_fundacion_museo date NOT NULL,
    id_lugar_geografico_museo numeric(3),

    constraint FK_id_lugar_geografico_museo FOREIGN KEY (id_lugar_geografico_museo)
        references LUGARES_GEOGRAFICOS(id_lugar_geografico)
);

CREATE TABLE HISTORICOS_MUSEOS(
    id_anio_historico_museo date NOT NULL,
    id_museo_historico_museo numeric(3) NOT NULL,
    hecho_historico_museo varchar(200) NOT NULL,

    constraint PK_historicos_museos PRIMARY KEY (id_anio_historico_museo, id_museo_historico_museo),

    constraint FK_id_museo_historico_museo FOREIGN KEY (id_museo_historico_museo)
        references MUSEOS(id_museo)
);

CREATE TABLE HORARIOS(          
    dia_horario numeric(1) NOT NULL,
    id_museo_horario numeric(3) NOT NULL,
    hora_apertura_horario time NOT NULL,
    hora_cierre_horario time NOT NULL,

    constraint PK_horarios PRIMARY KEY (dia_horario, id_museo_horario),

    constraint FK_id_museo_horario FOREIGN KEY (id_museo_horario)
        references MUSEOS(id_museo),

    constraint dia_horario check(dia_horario in (1,2,3,4,5,6,7)) /*1=domingo, 2=lunes, 3=martes, 4=miercoles, 5=jueves, 6=viernes, 7=sabado*/
);

CREATE TABLE TICKETS(
    id_ticket numeric(3) NOT NULL,
    id_museo_ticket numeric(3) NOT NULL,
    fecha_hora_venta_ticket timestamp NOT NULL,
    tipo_entrada_ticket varchar(12) NOT NULL,          
    monto_ticket numeric(6,2) NOT NULL,

    constraint PK_tickets PRIMARY KEY (id_ticket, id_museo_ticket),

    constraint FK_id_museo_ticket FOREIGN KEY (id_museo_ticket)
        references MUSEOS(id_museo),

    constraint tipo_entrada_ticket check(tipo_entrada_ticket in ('Adulto','Estudiante','Tercera Edad','Ninio'))
);

CREATE TABLE TIPOS_TICKETS(                         
    fecha_inicio_tipo_ticket date NOT NULL,
    id_museo_tipo_ticket numeric(3) NOT NULL,
    fecha_fin_tipo_ticket date NOT NULL,        
    tipo_tipo_ticket varchar(12) NOT NULL,             
    precio_tipo_ticket numeric(6,2) NOT NULL,

    constraint PK_tipos_tickets PRIMARY KEY (fecha_inicio_tipo_ticket, id_museo_tipo_ticket),

    constraint FK_id_museo_tipo_ticket FOREIGN KEY (id_museo_tipo_ticket)
        references MUSEOS(id_museo),

    constraint tipo_tipo_ticket check(tipo_tipo_ticket in ('Adulto','Estudiante','Tercera Edad','Ninio'))

);

CREATE TABLE EVENTOS(
    id_evento numeric(3) NOT NULL,
    id_museo_evento numeric(3) NOT NULL,
    titulo_evento varchar(50) NOT NULL,
    fecha_inicio_evento date NOT NULL,
    fecha_fin_evento date NOT NULL,
    costo_evento numeric(6,2),
    cantidad_personas_invitadas_evento numeric(3),
    nombre_instituto_evento varchar(50),

    constraint PK_eventos PRIMARY KEY (id_evento, id_museo_evento),

    constraint FK_id_museo_evento FOREIGN KEY (id_museo_evento)
        references MUSEOS(id_museo)
);

CREATE TABLE ESTRUCTURAS_ORGANIZACIONALES(
    id_estruc_estructura_organizacional numeric(3) NOT NULL,
    id_museo_estructura_organizacional numeric(3) NOT NULL,
    nombre_estructura_organizacional varchar(50) NOT NULL,
    tipo_estructura_organizacional varchar(16) NOT NULL,
    nivel_estructura_organizacional numeric(1) NOT NULL,           /*debo de preguntar que es esto de nivel*/
    descripcion_estructura_organizacional varchar(100) NOT NULL,
    id_gerencia_estructura_organizacional numeric(3),
	id_gerencia_museo_estructura_organizacional numeric(3),

    constraint PK_estructuras_organizacionales PRIMARY KEY (id_estruc_estructura_organizacional, id_museo_estructura_organizacional),

    constraint FK_museo_estructura_organizacional FOREIGN KEY (id_museo_estructura_organizacional)
        references MUSEOS(id_museo),

    constraint FK_gerencia_estructura_organizacional FOREIGN KEY (id_gerencia_estructura_organizacional, id_gerencia_museo_estructura_organizacional)
        references ESTRUCTURAS_ORGANIZACIONALES(id_estruc_estructura_organizacional, id_museo_estructura_organizacional),

    constraint tipo_estructura_organizacional check(tipo_estructura_organizacional in ('direccion','departamento','subdepartamento','subseccion'))
);

CREATE TABLE COLECCIONES(
    id_coleccion numeric(3) NOT NULL,
    id_estruc_orga_coleccion numeric(3) NOT NULL,
    id_museo_coleccion numeric(3) NOT NULL,
    nombre_coleccion varchar(50) NOT NULL,
    descripcion_caracteristica_coleccion varchar(100) NOT NULL,

    constraint PK_colecciones PRIMARY KEY (id_coleccion, id_estruc_orga_coleccion, id_museo_coleccion),

    constraint FK_estruc_orga_coleccion FOREIGN KEY (id_estruc_orga_coleccion, id_museo_coleccion)
        references ESTRUCTURAS_ORGANIZACIONALES(id_estruc_estructura_organizacional, id_museo_estructura_organizacional)
);

CREATE TABLE ESTRUCTURAS_FISICAS(
	id_estructura_fisica numeric(3) NOT NULL,
	id_museo_estructura_fisica numeric(3) NOT NULL,
	nombre_estructura_fisica varchar(50) NOT NULL,
	tipo_estructura_fisica varchar(15) NOT NULL,
	descripcion_estructura_fisica varchar(50),
	direccion_edificio_estructura_fisica varchar(50),
	id_padre_estructura_fisica numeric(3),
	id_padre_museo_estructura_fisica numeric(3),
	
	constraint PK_estructura_fisica PRIMARY KEY (id_estructura_fisica, id_museo_estructura_fisica),

	constraint FK_id_museo_estructura_fisica FOREIGN KEY (id_museo_estructura_fisica)
		references MUSEOS(id_museo),

	constraint FK_estructuras_fisicas FOREIGN KEY (id_padre_estructura_fisica, id_padre_museo_estructura_fisica)
		references ESTRUCTURAS_FISICAS(id_estructura_fisica, id_museo_estructura_fisica),

	constraint tipo_estructura_fisica check(tipo_estructura_fisica in ('e','p','a'))
);

CREATE TABLE PERSONAL_MANT_VIGILANCIA(          /*debo de preguntar si esto va en plural*/
    id_personal_mant_vigilancia numeric(3) PRIMARY KEY,
    nombre_personal_mant_vigilancia varchar(50) NOT NULL,
    apellido_personal_mant_vigilancia varchar(50) NOT NULL,
    doc_identidad_personal_mant_vigilancia varchar(10) NOT NULL UNIQUE,            /*debo de preguntar como se debe simbolizar el documento de identidad*/
    tipo_personal_mant_vigilancia varchar(13) NOT NULL,

    constraint tipo_personal_mant_vigilancia check(tipo_personal_mant_vigilancia in ('Mantenimiento','Vigilancia'))
);

CREATE TABLE ASIGNACIONES_MENSUALES(
    id_mes_anio date NOT NULL,
    id_estruc_fis_asignacion_mensual numeric(3) NOT NULL,
    id_museo_asignacion_mensual numeric(3) NOT NULL,
    id_personal_mant_vig numeric(3) NOT NULL,
    turno_asignacion_mensual varchar(10) NOT NULL,

    constraint PK_asignaciones_mensuales PRIMARY KEY (id_mes_anio, id_estruc_fis_asignacion_mensual, id_museo_asignacion_mensual, id_personal_mant_vig),

    constraint FK_id_estruc_fis_asignacion_mensual FOREIGN KEY (id_estruc_fis_asignacion_mensual, id_museo_asignacion_mensual)  
        references ESTRUCTURAS_FISICAS(id_estructura_fisica, id_museo_estructura_fisica),
    
    constraint FK_id_personal_mant_vig FOREIGN KEY (id_personal_mant_vig)
        references PERSONAL_MANT_VIGILANCIA(id_personal_mant_vigilancia),

    constraint turno_asignacion_mensual check(turno_asignacion_mensual in ('matutino','vespertino','nocturno'))
);

CREATE TABLE SALAS_EXPOSICIONES(
    id_sala_exposicion numeric(3) NOT NULL,
    id_estruc_fis_sala_exposicion numeric(3) NOT NULL,
    id_museo_sala_exposicion numeric(3) NOT NULL,

    nombre_sala_exposicion varchar(50),
    descripcion_sala_exposicion varchar(100),

    constraint PK_salas_exposiciones PRIMARY KEY (id_sala_exposicion, id_estruc_fis_sala_exposicion, id_museo_sala_exposicion),

    constraint FK_id_estruc_fis_sala_exposicion FOREIGN KEY (id_estruc_fis_sala_exposicion, id_museo_sala_exposicion)
        references ESTRUCTURAS_FISICAS(id_estructura_fisica, id_museo_estructura_fisica)
);

CREATE TABLE SAL_COL(
    id_museo_sal_col numeric(3) NOT NULL,
    id_estructura_fisica_sal_col numeric(3) NOT NULL,
    id_sala_exposicion_sal_col numeric(3) NOT NULL,
    id_estruc_orga_sal_col numeric(3) NOT NULL,
    id_coleccion_sal_col numeric(3) NOT NULL,

    orden_sal_col varchar(50),                     /*debo de preguntar que es el orden y asi acomodar la cant del varchar*/

    constraint PK_sal_col PRIMARY KEY (id_museo_sal_col, id_estructura_fisica_sal_col, id_sala_exposicion_sal_col, id_estruc_orga_sal_col, id_coleccion_sal_col),

    constraint FK_id_sala_exposicion_sal_col FOREIGN KEY (id_museo_sal_col, id_estructura_fisica_sal_col, id_sala_exposicion_sal_col)
        references SALAS_EXPOSICIONES(id_sala_exposicion, id_estruc_fis_sala_exposicion, id_museo_sala_exposicion),

    constraint FK_id_coleccion_sal_col FOREIGN KEY (id_museo_sal_col, id_estruc_orga_sal_col, id_coleccion_sal_col)
        references COLECCIONES(id_coleccion, id_estruc_orga_coleccion, id_museo_coleccion)
);

CREATE TABLE HISTORICOS_CIERRES_TEMPORALES(
    id_museo_hist_cie_tem numeric(3) NOT NULL,
    id_estructura_fisica_hist_cie_tem numeric(3) NOT NULL,
    id_sala_exposicion_hist_cie_tem numeric(3) NOT NULL,
    fecha_inicio_hist_cie_tem date NOT NULL,

    fecha_fin_hist_cie_tem date,

    constraint PK_historico_cierre_temporal PRIMARY KEY (id_museo_hist_cie_tem, id_estructura_fisica_hist_cie_tem, id_sala_exposicion_hist_cie_tem, fecha_inicio_hist_cie_tem),

    constraint FK_sala_exposicion_hist_cie_tem FOREIGN KEY (id_museo_hist_cie_tem, id_estructura_fisica_hist_cie_tem, id_sala_exposicion_hist_cie_tem)
        references SALAS_EXPOSICIONES(id_sala_exposicion, id_estruc_fis_sala_exposicion, id_museo_sala_exposicion)
);

CREATE TABLE EMPLEADOS_PROFESIONALES(
    id_empleado_profesional numeric(3) PRIMARY KEY,
    primer_nombre_empleado_profesional varchar(10) NOT NULL,
    segundo_nombre_empleado_profesional varchar(10),
    primer_apellido_empleado_profesional varchar(10) NOT NULL,
    segundo_apellido_empleado_profesional varchar(10) NOT NULL,
    fecha_nacimiento_empleado_profesional date NOT NULL,
    sexo_empleado_profesional varchar(1) NOT NULL,   
    id_lugar_geografico_empleado_profesional numeric(3),
    
    constraint FK_lugar_geografico_empleado_profesional FOREIGN KEY (id_lugar_geografico_empleado_profesional)
        references LUGARES_GEOGRAFICOS(id_lugar_geografico),

    constraint sexo_empleado_profesional check(sexo_empleado_profesional in ('M','F')) 
);

CREATE TABLE HISTORICOS_TRABAJOS(
    id_museo_historico_trabajo numeric(3) NOT NULL,
    id_estruc_estructura_organizacional_historico_trabajo numeric(3) NOT NULL,
    id_empleado_historico_trabajo numeric(3) NOT NULL,
    fecha_inicio_historico_trabajo date NOT NULL,
    
    fecha_fin_historico_trabajo date,
    cargo_historico_trabajo varchar(15) NOT NULL,

    constraint PK_historicos_trabajos PRIMARY KEY (id_museo_historico_trabajo, id_estruc_estructura_organizacional_historico_trabajo, id_empleado_historico_trabajo, fecha_inicio_historico_trabajo),

    constraint FK_estructura_organizacional FOREIGN KEY (id_museo_historico_trabajo, id_estruc_estructura_organizacional_historico_trabajo)
        references ESTRUCTURAS_ORGANIZACIONALES(id_estruc_estructura_organizacional, id_museo_estructura_organizacional),

    constraint FK_empleado_historico_trabajo FOREIGN KEY (id_empleado_historico_trabajo)
        references EMPLEADOS_PROFESIONALES(id_empleado_profesional),

    constraint cargo_historico_trabajo check(cargo_historico_trabajo in ('director','curador','restaurador','administrativo'))
);

CREATE TABLE TITULOS_PROFESIONALES(
    id_titulo_profesional numeric(3) NOT NULL,
    id_empleado_titulo_profesional numeric(3) NOT NULL,
    nombre_titulo_profesional varchar(50) NOT NULL,
    anio_titulo_profesional date NOT NULL,
    descripcion_especialidad_titulo_profesional varchar(100) NOT NULL,

    constraint PK_titulos_profesionales PRIMARY KEY (id_titulo_profesional, id_empleado_titulo_profesional),

    constraint FK_id_empleado_titulo_profesional FOREIGN KEY (id_empleado_titulo_profesional)
        references EMPLEADOS_PROFESIONALES(id_empleado_profesional)
);

CREATE TABLE IDIOMAS(
    id_idioma numeric(3) PRIMARY KEY,
    nombre_idioma varchar(20) NOT NULL
);

CREATE TABLE E_I(
    id_empleado_E_I numeric(3) NOT NULL,
    id_idioma_E_I numeric(3) NOT NULL,

    constraint PK_e_i PRIMARY KEY (id_empleado_E_I, id_idioma_E_I),

    constraint FK_empleado_E_I FOREIGN KEY (id_empleado_E_I)
        references EMPLEADOS_PROFESIONALES(id_empleado_profesional),

    constraint FK_idioma_E_I FOREIGN KEY (id_idioma_E_I)
        references IDIOMAS(id_idioma)
);

CREATE TABLE ARTISTAS(
    id_artista numeric(3) PRIMARY KEY,
    primer_nombre_artista varchar(10),
    segundo_nombre_artista varchar(10),
    primer_apellido_artista varchar(10),
    segundo_apellido_artista varchar(10),
    fecha_nacimiento_artista date,
    fecha_fallecimiento_artista date,
    nombre_artistico_artista varchar(50),
    resumen_caracteristicas_artista varchar(100) NOT NULL,
    id_lugar_artista numeric(3),

    constraint FK_id_lugar_artista FOREIGN KEY (id_lugar_artista)
        references LUGARES_GEOGRAFICOS(id_lugar_geografico)
);

CREATE TABLE OBRAS(
    id_obra numeric(3) PRIMARY KEY,
    nombre_obra varchar(50) NOT NULL,
    fecha_elaboracion_obra date NOT NULL,
    dimensiones_obra varchar(20) NOT NULL,
    tipo_obra varchar(10) NOT NULL,
    caracteristicas_estilo_movimiento_obra varchar(50) NOT NULL,
    caracteristicas_tecnicas_manteriales_obra varchar(50) NOT NULL,

    constraint tipo_obra check(tipo_obra in ('pintura','escultura'))
);

CREATE TABLE O_A(
    id_obra_O_A numeric(3) NOT NULL,
    id_artista_O_A numeric(3) NOT NULL,

    constraint PK_o_a PRIMARY KEY (id_obra_O_A, id_artista_O_A),

    constraint FK_obra_O_A FOREIGN KEY (id_obra_O_A)
        references OBRAS(id_obra),

    constraint FK_artista_O_A FOREIGN KEY (id_artista_O_A)
        references ARTISTAS(id_artista)
);

CREATE TABLE MOVILIDADES_HISTORICOS_OBRAS(
    id_museo_mov_his_obra numeric(3) NOT NULL,
    id_obra_mov_his_obra numeric(3) NOT NULL,
    id_cant_museo_mov_his_obra numeric(3) NOT NULL,

    fecha_inicio_mov_his_obra date NOT NULL,
    fecha_fin_mov_his_obra date,
    modo_adquisicion_mov_his_obra varchar(23) NOT NULL,
    destacada_mov_his_obra varchar(2) NOT NULL,
    orden_mov_his_obra varchar(50),
    valor_monetario_mov_his_obra numeric(6,2) NOT NULL,

    id_coleccion_mov_his_obra numeric(3),
    id_estruc_orga_coleccion_mov_his_obra numeric(3),  -- Nueva columna
    id_museo_coleccion_mov_his_obra numeric(3),        -- Nueva columna
    id_sala_exposicion_mov_his_obra numeric(3),
    id_estruc_fis_sala_exposicion_mov_his_obra numeric(3),  -- Nueva columna
    id_museo_sala_exposicion_mov_his_obra numeric(3),        -- Nueva columna
    id_empleado_profesional_mov_his_obra numeric(3),

    constraint PK_mov_his_obra PRIMARY KEY (id_museo_mov_his_obra, id_obra_mov_his_obra, id_cant_museo_mov_his_obra),

    constraint FK_museo_mov_his_obra FOREIGN KEY (id_museo_mov_his_obra)
        references MUSEOS(id_museo),

    constraint FK_obra_mov_his_obra FOREIGN KEY (id_obra_mov_his_obra)
        references OBRAS(id_obra),

    constraint FK_coleccion_mov_his_obra FOREIGN KEY (id_coleccion_mov_his_obra, id_estruc_orga_coleccion_mov_his_obra, id_museo_coleccion_mov_his_obra)
        references COLECCIONES(id_coleccion, id_estruc_orga_coleccion, id_museo_coleccion),

    constraint FK_sala_exposicion_mov_his_obra FOREIGN KEY (id_sala_exposicion_mov_his_obra, id_estruc_fis_sala_exposicion_mov_his_obra, id_museo_sala_exposicion_mov_his_obra)
        references SALAS_EXPOSICIONES(id_sala_exposicion, id_estruc_fis_sala_exposicion, id_museo_sala_exposicion),

    constraint FK_empleado_profesional_mov_his_obra FOREIGN KEY (id_empleado_profesional_mov_his_obra)
        references EMPLEADOS_PROFESIONALES(id_empleado_profesional),

    constraint modo_adquisicion_mov_his_obra check(modo_adquisicion_mov_his_obra in ('comprada','donada','comprada a otro museo','donada por otro museo')),

    constraint destacada_mov_his_obra check(destacada_mov_his_obra in ('si','no'))
);

CREATE TABLE MANTENIMIENTOS_OBRAS(
    id_museo_mantenimiento_obra numeric(3) NOT NULL,
    id_obra_mantenimiento_obra numeric(3) NOT NULL,
    id_mov_his_obra_mantenimiento_obra numeric(3) NOT NULL,
    id_mantenimiento_obra numeric(3) NOT NULL,
    actividad_mantenimiento_obra varchar(100) NOT NULL,
    frecuencia_mantenimiento_obra varchar(20) NOT NULL,
    tipo_responsable_mantenimiento_obra varchar(11) NOT NULL,

    constraint PK_mantenimientos_obras PRIMARY KEY (id_museo_mantenimiento_obra, id_obra_mantenimiento_obra, id_mov_his_obra_mantenimiento_obra, id_mantenimiento_obra),

    constraint FK_movilidad_historica_mantenimiento_obra FOREIGN KEY (id_museo_mantenimiento_obra, id_obra_mantenimiento_obra, id_mov_his_obra_mantenimiento_obra)
        references MOVILIDADES_HISTORICOS_OBRAS(id_museo_mov_his_obra, id_obra_mov_his_obra, id_cant_museo_mov_his_obra),

    constraint tipo_responsable_mantenimiento_obra check(tipo_responsable_mantenimiento_obra in ('curador','restaurador','otro'))
);

CREATE TABLE HISTORIAL_MANTENIMIENTOS(
    id_museo_historial_mantenimiento numeric(3) NOT NULL,
    id_obra_historial_mantenimiento numeric(3) NOT NULL,
    id_mov_his_obra_mantenimiento_obra numeric(3) NOT NULL,
    id_mantenimiento_obra_historial_mantenimiento numeric(3) NOT NULL,
    id_historial_mantenimiento numeric(3) NOT NULL,

    fecha_inicio_historial_mantenimiento date NOT NULL,
    fecha_fin_historico_mantenimiento date,
    observaciones_historial_mantenimiento varchar(100) NOT NULL,

    id_empleado_profesional_historial_mantenimiento numeric(3),

    constraint PK_historial_mantenimientos PRIMARY KEY (id_museo_historial_mantenimiento, id_obra_historial_mantenimiento, id_mov_his_obra_mantenimiento_obra, id_mantenimiento_obra_historial_mantenimiento, id_historial_mantenimiento),

    constraint FK_id_mantenimiento_obra_historial_mantenimiento FOREIGN KEY (id_museo_historial_mantenimiento, id_obra_historial_mantenimiento, id_mov_his_obra_mantenimiento_obra, id_mantenimiento_obra_historial_mantenimiento)
        references MANTENIMIENTOS_OBRAS(id_museo_mantenimiento_obra, id_obra_mantenimiento_obra, id_mov_his_obra_mantenimiento_obra, id_mantenimiento_obra),

    constraint FK_id_empleado_profesional_historial_mantenimiento FOREIGN KEY (id_empleado_profesional_historial_mantenimiento)
        references EMPLEADOS_PROFESIONALES(id_empleado_profesional)
);
