import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

BasePrompt {
    labelText: settings.user == "" ? "Vous devez configurer votre compte avant tout... \n Merci!" :
                                                      "Êtes vous sur de vouloir sauvegarder les changements?\nNom: " +
                                                     getFullName() + "\nMatricule: " + getMatricule();
    cancelText: "Non"
    confirmText: "Oui"
}
