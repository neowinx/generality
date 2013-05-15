<#import "*/gen-options.ftl" as opt>
package ${opt.factoriesPackage};
<#assign entityName = tableName?replace("_", " ")?capitalize?replace(" ", "")>
<#assign entityNameMixedCase = entityName?uncap_first>
import java.util.List;
import java.util.Vector;

import javax.faces.model.SelectItem;
import javax.persistence.EntityManager;

import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Factory;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.contexts.Context;
import org.jboss.seam.contexts.Contexts;

import ${opt.enumPackage}.*;

import ${opt.entityPackage}.${entityName};

/**
 * Component that contains the factories associated with ${entityName}.
 * Feel free to put the variables in the adequate contexts.
 * Generated by Generality
 */
@Name("${entityName?uncap_first}Factories")
public class ${entityName}Factories {

	@In EntityManager entityManager;

	public static final String CONTEXT_VAR_NAME = "${entityNameMixedCase}s";
	public static final String[] CONTEXT_VAR_NAMES = {CONTEXT_VAR_NAME, CONTEXT_VAR_NAME + "SelectItems"};
	public static Context[] CONTEXTS = {Contexts.get${opt.defaultContextForFactories}Context(), Contexts.get${opt.defaultContextForFactories}Context()};
	
	@SuppressWarnings("unchecked")
	@Factory(value=CONTEXT_VAR_NAME, scope=ScopeType.EVENT)
	public List<${entityName}> get${entityName}s(){
		try{
			return entityManager.createQuery(" select o from " + ${entityName}.class.getName() + " o").getResultList();
		}catch(Exception ex){
			return new Vector<${entityName}>();
		}
	}
	
	@Factory(value=CONTEXT_VAR_NAME + "SelectItems", scope=ScopeType.EVENT)
	public List<SelectItem> get${entityName}SelectItems(){
		List<SelectItem> si = new Vector<SelectItem>();
		for(${entityName} o : get${entityName}s())
<#assign attrname = opt.camelCase(opt.keyColumn) />
<#list columns as column>
	<#if opt.sqlStringTypes?seq_contains(column.dataType)>	
		<#assign attrname = opt.camelCase(column) />
		<#break />
	</#if>
</#list>
			si.add(new SelectItem(o.get${opt.camelCase(opt.keyColumn)}(),"" + o.get${attrname}()));
		return si;
	}
<#if (opt.staticValuesFields?? && opt.staticValuesFields?seq_contains(tableName))>
	<#list opt.staticValuesFields[opt.staticValuesFields?seq_index_of(tableName) + 1] as svfColumn>
		<#if (svfColumn?is_string)>
			<#assign enumName = opt.camelCaseStr(tableName) + opt.camelCaseStr(svfColumn) />

	@Factory(value="${enumName?uncap_first}SelectItems", scope=ScopeType.APPLICATION)
	public List<SelectItem> get${enumName}SelectItems(){
		List<SelectItem> si = new Vector<SelectItem>();
		for(${enumName} o : ${enumName}.values())
			si.add(new SelectItem(o.getId(),"" + o.getDescripcion()));
		return si;
	}
		</#if>
	</#list>
</#if>
}
