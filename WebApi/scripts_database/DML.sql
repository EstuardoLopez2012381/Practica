Call sp_insertUsuario('ADMIN8', 'admin123');

Call SP_updateUsuario('Estuardo', 'elopez', NULL, 2);

Call sp_autenticarUsuario('Estuardo', 'elopez');

Call SP_selectUsuario();

Call SP_deleteUsuario(1);

Call SP_insertTarea('Practica 4', 'Practica Hardcore', '2017-07-14 12:00:00');

Call SP_selectTarea();