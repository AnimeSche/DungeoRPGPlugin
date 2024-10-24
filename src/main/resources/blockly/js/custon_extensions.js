Blockly.Extensions.register('custom_playerclass_variables', function () {
    this.getInput("playerclassvar").appendField(new Blockly.FieldDropdown(getVariablesOfType("PlayerClass")), 'PLAYERCLASSVAR');
});
