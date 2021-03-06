<?php

class %%CLASSNAME%%InjectionInjection extends %%CLASSNAME%% implements PluginDatainjectionInjectionInterface
{
   static $rightname = 'plugin_datainjection_model';

   /**
    * Return the table used to stor this object
    *
    * @see CommonDBTM::getTable()
    *
    * @return string
   **/
   static function getTable()
   {
      return getTableForItemType(get_parent_class());
   }

   /**
    * Tells datainjection is the type is a primary type or not
    *
    * @return a boolean
   **/
   function isPrimaryType()
   {
      return true;
   }

   /**
    * Indicates to with other types it can be connected
    *
    * @return an array of GLPI types
   **/
   function connectedTo()
   {
      return array();
   }

   /**
    * Function which calls getSearchOptions and add more parameters specific to display
    *
    * @param $primary_type    (default '')
    *
    * @return an array of search options, as defined in each commondbtm object
   **/
   function getOptions($primary_type='')
   {
      $searchoptions = PluginFieldsContainer::getAddSearchOptions('%%ITEMTYPE%%', %%CONTAINER_ID%%);

      foreach ($searchoptions as $id => $datas) {
         $searchoptions[$id]['injectable'] = PluginDatainjectionCommonInjectionLib::FIELD_INJECTABLE;
         if (!isset($searchoptions[$id]['displaytype'])) {
            if (isset($searchoptions[$id]['datatype'])) {
               $searchoptions[$id]['displaytype'] = $searchoptions[$id]['datatype'];
            } else {
               $searchoptions[$id]['displaytype'] = 'text';
            }
         }
      }

      return $searchoptions;
   }

   /**
    * Standard method to add an object into glpi
    *
    * @param $values    array fields to add into glpi
    * @param $options   array options used during creation
    *
    * @return an array of IDs of newly created objects:
    * for example array(Computer=>1, Networkport=>10)
   **/
   function addOrUpdateObject($values=array(), $options=array())
   {
      $lib = new PluginDatainjectionCommonInjectionLib($this, $values, $options);
      $lib->processAddOrUpdate();
      return $lib->getInjectionResults();
   }

   /**
    * Standard method to delete an object into glpi
    *
    * @param fields fields to add into glpi
    * @param options options used during creation
    *
    * @return an array which contains the reformat/check/injection logs
    **/
   function deleteObject($values = array(), $options = array())
   {
      $lib = new PluginDatainjectionCommonInjectionLib($this, $values, $options);
      $lib->deleteObject();
      return $lib->getInjectionResults();
   }
}
