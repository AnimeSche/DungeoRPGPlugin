<#function mappedMCPlayerToPlayerClassCode mappedBlock amount=1>
    <#if mappedBlock?starts_with("/*@PlayerClass*/")>
        <#return mappedBlock?replace("/*@PlayerClass*/", "")>
    <#elseif mappedBlock?contains("/*@?*/")>
        <#assign outputs = mappedBlock?keep_after("/*@?*/")?keep_before_last(")")>
        <#return mappedBlock?keep_before("/*@?*/") + "?" + mappedMCPlayerToPlayerClassCode(outputs?keep_before("/*@:*/"), amount)
            + ":" + mappedMCPlayerToPlayerClassCode(outputs?keep_after("/*@:*/"), amount) + ")">
    <#elseif mappedBlock?starts_with("CUSTOM:")>
        <#return toPlayerClass(mappedElementToRegistryEntry(mappedBlock), amount)>
    <#else>
        <#return toPlayerClass(mappedBlock, amount)>
    </#if>
</#function>

<#function toPlayerClass player amount>
    <#if amount == 1>
        <#return "new PlayerClass(player)">
    <#else>
        <#return "new PlayerClass(player," + (amount == amount?floor)?then(amount + ")","(int)(" + amount + "))")>
    </#if>
</#function>

<#function mappedElementToRegistryEntry mappedElement>
    <#return JavaModName + generator.isBlock(mappedElement)?then("Blocks", "Items") + "."
    + generator.getRegistryNameFromFullName(mappedElement)?upper_case + transformExtension(mappedElement)?upper_case + ".get()">
</#function>