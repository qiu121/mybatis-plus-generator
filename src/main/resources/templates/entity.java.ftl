package ${package.Entity};

<#list table.importPackages as pkg>
import ${pkg};
</#list>
<#assign hasDateField = false />
<#assign hasSerialAnnotation = false />
<#if entitySerialVersionUID>
    <#assign hasSerialAnnotation = true />
</#if>
<#list table.fields as field>
    <#if field.propertyType?lower_case == "date" 
    || field.propertyType?lower_case == "datetime" 
    || field.propertyType?lower_case == "timestamp"
    || field.propertyType?lower_case == "time"
    || field.propertyType?lower_case == "localdatetime"
    || field.propertyType?lower_case == "localdate">
    <#assign hasDateField = true />
    </#if>
</#list>

<#if springdoc>
import io.swagger.v3.oas.annotations.media.Schema;
<#elseif swagger>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
<#if hasDateField>
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if hasSerialAnnotation>
import java.io.Serial;
</#if>
<#if entityLombokModel>
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
    <#if chainModel>
import lombok.experimental.Accessors;
    </#if>
</#if>

/**
* @author ${author}
* @date ${date}
* @version 1.0
*/
<#if entityLombokModel>
@Data
@NoArgsConstructor
@AllArgsConstructor
    <#if chainModel>
@Accessors(chain = true)
    </#if>
</#if>
<#--<#if table.convert>-->
@TableName("${schemaName}`${table.name}`")
<#--</#if>-->
<#if springdoc>
@Schema(name = "${entity}", description = "${table.comment!}")
<#elseif swagger>
@ApiModel(value = "${entity}对象", description = "${table.comment!}")
</#if>
<#if superEntityClass??>
public class ${entity} extends ${superEntityClass}<#if activeRecord><${entity}></#if> {
<#elseif activeRecord>
public class ${entity} extends Model<${entity}> {
<#elseif entitySerialVersionUID>
public class ${entity} implements Serializable {
<#else>
public class ${entity} {
</#if>
<#if entitySerialVersionUID>
    @Serial
    private static final long serialVersionUID = 1L;
</#if>
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>

    <#if field.comment!?length gt 0>
        <#if springdoc>
    @Schema(description = "${field.comment}")
        <#elseif swagger>
    @ApiModelProperty("${field.comment}")
        <#else>
    /**
     * ${field.comment}
     */
        </#if>
    </#if>
    <#if field.keyFlag>
        <#-- 主键 -->
        <#if field.keyIdentityFlag>
    @TableId(value = "${field.annotationColumnName}", type = IdType.AUTO)
        <#elseif idType??>
    @TableId(value = "${field.annotationColumnName}", type = IdType.${idType})
        <#elseif field.convert>
    @TableId("${field.annotationColumnName}")
        </#if>
        <#-- 普通字段 -->
    <#elseif field.fill??>
    <#-- -----   存在字段填充设置   ----->
        <#if field.convert>
    @TableField(value = "${field.annotationColumnName}", fill = FieldFill.${field.fill})
        <#else>
    @TableField(fill = FieldFill.${field.fill})
        </#if>
    <#elseif field.convert>
    @TableField("${field.annotationColumnName}")
    </#if>
    <#-- 乐观锁注解 -->
    <#if field.versionField>
    @Version
    </#if>
    <#-- 逻辑删除注解 -->
    <#if field.logicDeleteField>
    @TableLogic
    </#if>
    <#if field.propertyType?lower_case == "date" 
    || field.propertyType?lower_case == "datetime" 
    || field.propertyType?lower_case == "timestamp"
    || field.propertyType?lower_case == "time"
    || field.propertyType?lower_case == "localdatetime"
    || field.propertyType?lower_case == "localdate">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    </#if>
    private ${field.propertyType} ${field.propertyName};
</#list>
<#------------  END 字段循环遍历  ---------->
<#if !entityLombokModel>
    <#list table.fields as field>
        <#if field.propertyType == "boolean">
            <#assign getprefix="is"/>
        <#else>
            <#assign getprefix="get"/>
        </#if>

    public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

    <#if chainModel>
    public ${entity} set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
    <#else>
    public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
    </#if>
        this.${field.propertyName} = ${field.propertyName};
        <#if chainModel>
        return this;
        </#if>
    }
    </#list>
</#if>
<#if entityColumnConstant>
    <#list table.fields as field>

    public static final String ${field.name?upper_case} = "${field.name}";
    </#list>
</#if>
<#if activeRecord>

    @Override
    public Serializable pkVal() {
    <#if keyPropertyName??>
        return this.${keyPropertyName};
    <#else>
        return null;
    </#if>
    }
</#if>
<#if !entityLombokModel>

    @Override
    public String toString() {
        return "${entity}{" +
    <#list table.fields as field>
        <#if field_index==0>
            "${field.propertyName} = " + ${field.propertyName} +
        <#else>
            ", ${field.propertyName} = " + ${field.propertyName} +
        </#if>
    </#list>
        "}";
    }
</#if>
}