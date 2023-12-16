package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};

/**
* @author ${author}
* @since ${date}
* @version 1.0
*/
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {

}
</#if>
