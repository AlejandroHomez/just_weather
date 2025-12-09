import 'dart:ui';

/// Clase que modela un error personalizado con diversas propiedades
/// para configurar la visualización y comportamiento del mismo.
///
/// [JwErrorItem] permite especificar detalles sobre el error y cómo debe
/// presentarse, así como las acciones asociadas con botones y otros aspectos
/// visuales.
///
class JwErrorItem {
  JwErrorItem({
    this.reason,
    this.domain,
    this.code,
    this.message,
    this.alertType = 'Error',
    this.title,
    this.primaryBtnLabel,
    this.secondaryBtnLabel,
    this.onPrimaryBtnPressed,
    this.onSecondaryBtnPressed,
  });

  String? reason;
  String? domain;
  String? code;
  String? message;
  String alertType;
  String? title;
  String? primaryBtnLabel;
  String? secondaryBtnLabel;
  VoidCallback? onPrimaryBtnPressed;
  VoidCallback? onSecondaryBtnPressed;
}
