${remoteClass.name}.hpp
/* Autogenerated with Kurento Idl */

#ifndef __${camelToUnderscore(remoteClass.name)}_HPP__
#define __${camelToUnderscore(remoteClass.name)}_HPP__

#include <jsoncpp/json/json.h>
#include <jsonrpc/JsonRpcException.hpp>
#include <memory>
#include <vector>
<#if (remoteClass.extends)??>
#include "${remoteClass.extends.name}.hpp"
</#if>
<#if remoteClass.events[0] ?? >
<#list remoteClass.events as event>
#include "${event.name}.hpp"
</#list>
#include <sigc++/sigc++.h>
</#if>

namespace kurento
{

<#list remoteClassDependencies(remoteClass) as dependency>
class ${dependency.name};
</#list>
class ${remoteClass.name};
class JsonSerializer;

void Serialize (std::shared_ptr<${remoteClass.name}> &object, JsonSerializer &serializer);

class ${remoteClass.name}<#if remoteClass.extends??><#rt>
   <#lt> : public virtual ${remoteClass.extends.name}
   <#else>
   <#lt> : public std::enable_shared_from_this<${remoteClass.name}>
</#if>
{

public:
  ${remoteClass.name} () {};
  virtual ~${remoteClass.name} () {};
  <#macro methodHeader method>
  virtual ${getCppObjectType(method.return,false)} ${method.name} (<#rt>
      <#lt><#list method.params as param>${getCppObjectType(param.type)}${param.name}<#if param_has_next>, </#if></#list>) = 0;
  </#macro>
  <#list remoteClass.methods as method><#rt>
    <#if method_index = 0 >

    </#if>
    <#list method.expandIfOpsParams() as expandedMethod ><#rt>
      <#lt><@methodHeader expandedMethod />
    </#list>
    <#lt><@methodHeader method />
  </#list>

  virtual std::string getType () const {
    return "${remoteClass.name}";
  }

  virtual void Serialize (JsonSerializer &serializer) = 0;
<#list remoteClass.properties as property>

  virtual ${getCppObjectType (property.type, false)} get${property.name?cap_first} () {
    return ${property.name};
  }
  <#if !property.final && !property.readOnly>

  virtual void set${property.name?cap_first} (${getCppObjectType (property.type, true)}${property.name}) {
    this->${property.name} = ${property.name};
  }
  </#if>
</#list>
<#if remoteClass.properties[0]??>

protected:

</#if>
<#list remoteClass.properties as property>
  ${getCppObjectType(property.type, false)} ${property.name};
</#list>

};

} /* kurento */

#endif /*  __${camelToUnderscore(remoteClass.name)}_HPP__ */