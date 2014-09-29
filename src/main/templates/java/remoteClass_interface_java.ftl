<#if remoteClass.name != "MediaPipeline">${packageToFolder(module.code.api.java.packageName)}/${remoteClass.name}.java
<#include "macros.ftm" >
/**
 * This file is generated with Kurento ktool-rom-processor.
 * Please don't edit. Changes should go to kms-interface-rom and
 * ktool-rom-processor templates.
 */
package ${module.code.api.java.packageName};

<#if module.code.api.java.packageName != "org.kurento.client">
import org.kurento.client.*;
</#if>

<@comment remoteClass.doc />
@org.kurento.client.internal.RemoteClass
public class ${remoteClass.name} extends <#if remoteClass.extends??>${remoteClass.extends.name}<#else>AbstractMediaObject</#if> {

   public ${remoteClass.name}(org.kurento.client.internal.client.RemoteObjectFacade remoteObject, Transaction tx) {
     super(remoteObject,tx);
   }

   <#list remoteClass.properties as property>
   public ${getJavaObjectType(property.type,false)} get${property.name?cap_first}(){
      <#assign type = getJavaObjectType(property.type,false)>
      <#if type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      return (${type})remoteObject.invoke("get${property.name?cap_first}", null, returnType);
      <#else>
      return (${type})remoteObject.invoke("get${property.name?cap_first}", null, ${type}.class);
      </#if>
   }

   public java.util.concurrent.Future<${getJavaObjectType(property.type,true)}> get${property.name?cap_first}(Transaction tx){
      <#assign type = getJavaObjectType(property.type,true)>
      <#if type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      return (java.util.concurrent.Future<${type}>)tx.<${type}>addOperation(new org.kurento.client.internal.client.operation.InvokeOperation(this, "get${property.name?cap_first}", null, returnType));
      <#else>
      return (java.util.concurrent.Future<${type}>)tx.<${type}>addOperation(new org.kurento.client.internal.client.operation.InvokeOperation(this, "get${property.name?cap_first}", null, ${type}.class));
      </#if>
   }

   public java.util.concurrent.Future<${getJavaObjectType(property.type,true)}> get${property.name?cap_first}WhenReady(){
      return get${property.name?cap_first}(this.getActiveTransaction());
   }

   public void get${property.name?cap_first}(Continuation<${getJavaObjectType(property.type,true)}> cont){
      <#assign type = getJavaObjectType(property.type,false)>
      <#if type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      remoteObject.invoke("get${property.name?cap_first}", null, returnType, cont);
      <#else>
      remoteObject.invoke("get${property.name?cap_first}", null, ${type}.class, cont);
      </#if>
   }
   </#list>

   <#list remoteClass.methods as method>

	 <@comment method.doc method.params method.return />
   public ${getJavaObjectType(method.return,false)} ${method.name}(<#rt>
		<#lt><#list method.params as param>${getJavaObjectType(param.type,false)} ${param.name}<#if param_has_next>, </#if></#list>){
      <#assign props = "null">
      <#if method.params?has_content>
      <#assign props = "props">
      org.kurento.jsonrpc.Props props = new org.kurento.jsonrpc.Props();
      <#list method.params as param>
      props.add("${param.name}", ${param.name});
      </#list>
      </#if>
      <#assign type = getJavaObjectType(method.return,false)>
      <#if type == "void">
      remoteObject.invoke("${method.name}", ${props}, Void.class);
      <#elseif type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      return (${type})remoteObject.invoke("${method.name}", ${props}, returnType);
      <#else>
      return (${type})remoteObject.invoke("${method.name}", ${props}, ${type}.class);
      </#if>
   }

   <@comment method.doc method.params method.return />
   public java.util.concurrent.Future<${getJavaObjectType(method.return,true)}> ${method.name}WhenReady(<#rt>
    <#lt><#list method.params as param>${getJavaObjectType(param.type,false)} ${param.name}<#if param_has_next>, </#if></#list>){
      return ${method.name}(<#list method.params as param>${param.name},</#list>this.getActiveTransaction());
   }

   <@comment method.doc method.params method.return />
   public java.util.concurrent.Future<${getJavaObjectType(method.return,true)}> ${method.name}(<#rt>
    <#lt><#list method.params as param>${getJavaObjectType(param.type,false)} ${param.name}, </#list>Transaction tx){
      <#assign props = "null">
      <#if method.params?has_content>
      <#assign props = "props">
      org.kurento.jsonrpc.Props props = new org.kurento.jsonrpc.Props();
      <#list method.params as param>
      props.add("${param.name}", ${param.name});
      </#list>
      </#if>
      <#assign type = getJavaObjectType(method.return,true)>
      <#if type == "void">
      tx.addOperation(new org.kurento.client.internal.client.operation.InvokeOperation(this, "${method.name}", ${props}, Void.class));
      <#elseif type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      return (java.util.concurrent.Future<${type}>)tx.<${type}>addOperation(new org.kurento.client.internal.client.operation.InvokeOperation(this, "${method.name}", ${props}, returnType));
      <#else>
      return (java.util.concurrent.Future<${type}>)tx.<${type}>addOperation(new org.kurento.client.internal.client.operation.InvokeOperation(this, "${method.name}", ${props}, ${type}.class));
      </#if>
   }

	<#assign doc>
Asynchronous version of ${method.name}:
{@link Continuation#onSuccess} is called when the action is
done. If an error occurs, {@link Continuation#onError} is called.

@see ${remoteClass.name}#${method.name}
    </#assign>
    <@comment doc method.params />
    public void ${method.name}(<#rt>
		<#lt><#list method.params as param>${getJavaObjectType(param.type,false)} ${param.name}, </#list>Continuation<${getJavaObjectType(method.return)}> cont){
      <#assign props = "null">
      <#if method.params?has_content>
      <#assign props = "props">
      org.kurento.jsonrpc.Props props = new org.kurento.jsonrpc.Props();
      <#list method.params as param>
      props.add("${param.name}", ${param.name});
      </#list>
      </#if>
      <#assign type = getJavaObjectType(method.return,false)>
      <#if type == "void">
      remoteObject.invoke("${method.name}", ${props}, Void.class, cont);
      <#elseif type?starts_with("java.util.List")>
      java.lang.reflect.Type returnType = new com.google.common.reflect.TypeToken<${type}>(){}.getType();
      remoteObject.invoke("${method.name}", ${props}, returnType, cont);
      <#else>
      remoteObject.invoke("${method.name}", ${props}, ${type}.class, cont);
      </#if>
   }

    </#list>
	<#list remoteClass.events as event>
    /**
     * Add a {@link EventListener} for event {@link ${event.name}Event}. Synchronous call.
     *
     * @param  listener Listener to be called on ${event.name}Event
     * @return ListenerSubscription for the given Listener
     *
     **/
    public ListenerSubscription add${event.name}Listener(EventListener<${event.name}Event> listener){
        return subscribeEventListener(listener, ${event.name}Event.class, null);
    }
    /**
     * Add a {@link EventListener} for event {@link ${event.name}Event}. Asynchronous call.
     * Calls Continuation&lt;ListenerSubscription&gt; when it has been added.
     *
     * @param listener Listener to be called on ${event.name}Event
     * @param cont     Continuation to be called when the listener is registered
     *
     **/
    public void add${event.name}Listener(EventListener<${event.name}Event> listener, Continuation<ListenerSubscription> cont){
        subscribeEventListener(listener, ${event.name}Event.class, cont);
    }
    </#list>

  <#if !remoteClass.abstract>

    public static Builder with(<#rt>
          <#assign first=true>
          <#lt><#list remoteClass.constructor.params as param>
          <#if !param.optional>
              <#lt><#if first><#assign first=false><#else>, </#if><#rt>
              <#lt>${getJavaObjectType(param.type,false)} ${param.name}<#rt>
          </#if>
          </#list>
          <#lt>){
       return new Builder(<#rt>
          <#assign first=true>
          <#lt><#list remoteClass.constructor.params as param>
          <#if !param.optional>
              <#lt><#if first><#assign first=false><#else>, </#if><#rt>
              <#lt>${param.name}<#rt>
          </#if>
          </#list>
          <#lt>);
    }

    public static class Builder extends AbstractBuilder<${remoteClass.name}> {

		<#assign doc="Creates a Builder for ${remoteClass.name}" />
		<@comment doc param />
		Builder(<#rt>
        	<#assign first=true>
        	<#lt><#list remoteClass.constructor.params as param>
        	<#if !param.optional>
            	<#lt><#if first><#assign first=false><#else>, </#if><#rt>
            	<#lt>${getJavaObjectType(param.type,false)} ${param.name}<#rt>
        	</#if>
        	</#list>
        	<#lt>){

			super(${remoteClass.name}.class,${remoteClass.constructor.params[0].name});

        	<#list remoteClass.constructor.params as param>
        	<#if !param.optional>
			props.add("${param.name}",${param.name});
        	</#if>
        	</#list>
		}

        <#list remoteClass.constructor.params as param>
        <#if param.optional>
        <#if param.type.name != "boolean" >
		<#assign par=[param] />
		<@comment  "Sets a value for ${param.name} in Builder for ${remoteClass.name}." par />
		public Builder with${param.name?cap_first}(${getJavaObjectType(param.type,false)} ${param.name}){
			props.add("${param.name}",${param.name});
			return this;
		}
        <#else>
            <@comment  param.doc />
		public Builder ${param.name}(){
			props.add("${param.name}",Boolean.TRUE);
			return this;
		}
		</#if>
        </#if>
       </#list>

       @Override
       protected ${remoteClass.name} createMediaObject(org.kurento.client.internal.client.RemoteObjectFacade remoteObject, Transaction tx) {
          return new ${remoteClass.name}(remoteObject, tx);
       }

    }
	</#if>
}
</#if>