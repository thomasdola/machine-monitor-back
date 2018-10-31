webpackJsonp([29],{1735:function(e,t,n){"use strict";function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function a(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!==typeof t&&"function"!==typeof t?e:t}function i(e,t){if("function"!==typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}Object.defineProperty(t,"__esModule",{value:!0});var c=n(0),u=n.n(c),l=n(58),s=n(41),f=n(8),d=n.n(f),p=n(27),w=n(42),k=n(1129),m=n(80),v=n.n(m),b=n(826),h=n(253),y=n.n(h),g=n(825),E=n(727),N=n(6),O=n(725),C=n(262),R=n(261),S=function(){function e(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}return function(t,n,r){return n&&e(t.prototype,n),r&&e(t,r),t}}(),_=function(e){function t(){var e,n,i,c;o(this,t);for(var u=arguments.length,l=Array(u),s=0;s<u;s++)l[s]=arguments[s];return n=i=a(this,(e=t.__proto__||Object.getPrototypeOf(t)).call.apply(e,[this].concat(l))),i.state={network:{},networkBuffer:{},networkRaw:{},confirmDelete:!1},i._handleInputChange=function(e,t){i.setState(function(){return{network:Object.assign({},i.state.network,r({},e,t))}})},i._handleDeleteNetwork=function(){i.props.deleteNetwork(i.props.authUser.token,i.state.network.id),i.setState({confirmDelete:!1})},i._handleEditNetwork=function(){var e=i.props,t=e.authUser.token,n=e.editNetwork,r=i.state,o=r.network,a=o.operator,c=o.type,u=r.networkRaw.id,l=new FormData;l.append("operator",a),l.append("type",c),n(t,u,l)},i._isFormValid=function(){var e=i.state.network,t=e.operator,n=e.type,r={operator:t,type:n};return Object(E.a)(r)},c=n,a(i,c)}return i(t,e),S(t,[{key:"componentDidUpdate",value:function(e){var t=e.OPERATION_SUCCESSFUL,n=e.OPERATION_FAILED,r=this.props,o=r.OPERATION_SUCCESSFUL,a=r.OPERATION_FAILED,i=r.history,c=r.authUser.token,u=r.loadNetworks;if(!v()(t,o)){u(c,{});var s=this.state.network.operator.toUpperCase();o.action===N._22&&(i.goBack(),O.a.show({message:s+" Successfully Updated \ud83d\ude03",intent:l.x.SUCCESS,icon:"tick"})),o.action===N.X&&(i.goBack(),O.a.show({message:s+" Successfully Deleted \ud83d\ude03",intent:l.x.SUCCESS,icon:"tick"}))}if(!v()(n,a)){var f=this.state.network.operator.toUpperCase();a.action===N._22&&(console.log(a.data),O.a.show({message:"Could Not Update "+f+" \ud83d\ude1e",intent:l.x.DANGER,icon:"error"})),a.action===N.X&&(console.log(a.data),O.a.show({message:"Could Not Delete "+f+" \ud83d\ude1e",intent:l.x.DANGER,icon:"error"}))}}},{key:"render",value:function(){var e=this,t=this.props,n=t.history,r=t.editingNetwork,o=t.deletingNetwork,a=t.authUser,i=this.state,c=i.network,s=c.operator,f=c.type,d=i.networkBuffer,p=i.network,w=(i.confirmDelete,i.networkRaw),k=!this._isFormValid()||v()(p,d),m=!w.id,h=!!a.root||C.a.User(a).perform(b.c,g.d,R.g),y=!!a.root||C.a.User(a).perform(b.b,g.d,R.g);return[u.a.createElement("div",{className:"bp3-dialog-body"},u.a.createElement("label",{className:"bp3-label"},"Operator",u.a.createElement("input",{value:s||"",name:"operator",onChange:function(t){var n=t.target,r=n.name,o=n.value;return e._handleInputChange(r,o)},className:"bp3-input bp3-fill",type:"text",dir:"auto"})),u.a.createElement("label",{className:"bp3-label"},"Network Type",u.a.createElement("input",{value:f||"",name:"type",onChange:function(t){var n=t.target,r=n.name,o=n.value;return e._handleInputChange(r,o)},className:"bp3-input bp3-fill",type:"text",dir:"auto"}))),u.a.createElement("div",{className:"bp3-dialog-footer"},u.a.createElement("div",{className:"bp3-dialog-footer-actions"},m&&u.a.createElement(l.e,{intent:l.x.PRIMARY,onClick:function(){return n.goBack()},icon:"undo",text:"Go Back"}),u.a.createElement(l.f,null,u.a.createElement(l.H,{isOpen:this.state.confirmDelete,interactionKind:l.I.CLICK,position:l.J.BOTTOM},u.a.createElement(l.e,{disabled:o||r||m||!y,loading:o,onClick:function(){return e.setState({confirmDelete:!0})},intent:l.x.DANGER,text:"delete",icon:"trash"}),u.a.createElement("div",{style:{padding:".5rem",display:"flex",flexDirection:"column"}},u.a.createElement("header",null,"Are you sure?"),u.a.createElement("div",{style:{display:"flex",justifyContent:"space-evenly",marginTop:".5rem"}},u.a.createElement(l.e,{onClick:this._handleDeleteNetwork,small:!0,text:"yes",intent:l.x.SUCCESS}),u.a.createElement(l.e,{onClick:function(){return e.setState({confirmDelete:!1})},small:!0,text:"no",intent:l.x.DANGER}))))),u.a.createElement(l.e,{disabled:k||o||m||!h,loading:r,intent:l.x.PRIMARY,onClick:this._handleEditNetwork,icon:"tick",text:"save"})))]}}],[{key:"getDerivedStateFromProps",value:function(e,t){var n=t.networkRaw,r=e.networks,o=e.match.params.id,a=y()(r,{id:Number.parseInt(o,10)})||{},i=Object.assign({},a);return v()(n,a)?null:{network:i,networkBuffer:Object.assign({},i),networkRaw:a}}}]),t}(u.a.Component);_.propTypes={history:d.a.object.isRequired,authUser:d.a.object.isRequired,match:d.a.object.isRequired,OPERATION_FAILED:d.a.object.isRequired,OPERATION_SUCCESSFUL:d.a.object.isRequired,editNetwork:d.a.func.isRequired,deleteNetwork:d.a.func.isRequired,loadNetworks:d.a.func.isRequired,editingNetwork:d.a.bool.isRequired,deletingNetwork:d.a.bool.isRequired,networks:d.a.array.isRequired};var A=function(e){return{authUser:e.authUser,OPERATION_FAILED:e.OPERATION_FAILED,OPERATION_SUCCESSFUL:e.OPERATION_SUCCESSFUL,editingNetwork:e.editingNetwork,deletingNetwork:e.deletingNetwork,networks:e.networks}},U=function(e){return Object(w.b)({deleteNetwork:k.b,editNetwork:k.c,loadNetworks:k.d},e)};t.default=Object(s.f)(Object(p.b)(A,U)(_))},725:function(e,t,n){"use strict";var r=n(58);t.a=r.T.create({position:r.J.TOP})},727:function(e,t,n){"use strict";function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e){if(Array.isArray(e)){for(var t=0,n=Array(e.length);t<e.length;t++)n[t]=e[t];return n}return Array.from(e)}function a(e){var t=[];return c()(e,function(e,n){if("number"===typeof e)if(e){var a;t=[].concat(o(t),[(a={},r(a,n,e),r(a,"valid",!0),a)])}else{var i;t=[].concat(o(t),[(i={},r(i,n,e),r(i,"valid",!1),i)])}else if("string"===typeof e)if(e.trim().length>0){var c;t=[].concat(o(t),[(c={},r(c,n,e),r(c,"valid",!0),c)])}else{var u;t=[].concat(o(t),[(u={},r(u,n,e),r(u,"valid",!1),u)])}else if(l()(e))if(e.length>0){var s;t=[].concat(o(t),[(s={},r(s,n,e),r(s,"valid",!0),s)])}else{var f;t=[].concat(o(t),[(f={},r(f,n,e),r(f,"valid",!1),f)])}else{var d;t=[].concat(o(t),[(d={},r(d,n,e),r(d,"valid",!1),d)])}}),console.log("form validation",t),f()(t,"valid")}t.a=a;var i=n(729),c=n.n(i),u=n(14),l=n.n(u),s=n(731),f=n.n(s)},729:function(e,t,n){function r(e,t){return e&&o(e,a(t))}var o=n(256),a=n(730);e.exports=r},730:function(e,t,n){function r(e){return"function"==typeof e?e:o}var o=n(60);e.exports=r},731:function(e,t,n){function r(e,t,n){var r=c(e)?o:a;return n&&u(e,t,n)&&(t=void 0),r(e,i(t,3))}var o=n(732),a=n(733),i=n(59),c=n(14),u=n(257);e.exports=r},732:function(e,t){function n(e,t){for(var n=-1,r=null==e?0:e.length;++n<r;)if(!t(e[n],n,e))return!1;return!0}e.exports=n},733:function(e,t,n){function r(e,t){var n=!0;return o(e,function(e,r,o){return n=!!t(e,r,o)}),n}var o=n(136);e.exports=r},825:function(e,t,n){"use strict";n.d(t,"i",function(){return r}),n.d(t,"c",function(){return o}),n.d(t,"g",function(){return a}),n.d(t,"e",function(){return i}),n.d(t,"b",function(){return c}),n.d(t,"a",function(){return u}),n.d(t,"h",function(){return l}),n.d(t,"d",function(){return s}),n.d(t,"f",function(){return f});var r="user",o="log",a="role",i="policy",c="center",u="application",l="service",s="network",f="printer"},826:function(e,t,n){"use strict";n.d(t,"a",function(){return r}),n.d(t,"b",function(){return o}),n.d(t,"c",function(){return a}),n.d(t,"d",function(){return i});var r="add",o="delete",a="edit",i="export"}});
//# sourceMappingURL=29.1323207b.chunk.js.map