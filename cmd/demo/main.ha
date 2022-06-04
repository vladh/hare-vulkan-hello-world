use fmt;
use types;
use vk;

fn str_to_cstr(in: const str) *const char = {
	return ((&in): *const types::string).data: *const char;
};

fn create_instance(
	program_name: str,
	engine_name: str,
	use_validations: bool
) (vk::VkInstance | vk::VkResult) = {
	vk::load_loader();

	const appInfo = vk::VkApplicationInfo {
		sType = vk::VkStructureType::VK_STRUCTURE_TYPE_APPLICATION_INFO,
		pNext = null,
		pApplicationName = str_to_cstr(program_name),
		applicationVersion = vk::VK_MAKE_API_VERSION(0, 0, 0, 1),
		pEngineName = str_to_cstr(engine_name),
		engineVersion = vk::VK_MAKE_API_VERSION(0, 0, 0, 1),
		apiVersion = vk::VK_API_VERSION_1_0,
	};
	const ci = vk::VkInstanceCreateInfo {
		sType = vk::VkStructureType::VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
		pNext = null,
		flags = 0,
		enabledLayerCount = 0,
		pApplicationInfo = &appInfo,
		ppEnabledLayerNames = null,
		enabledExtensionCount = 0,
		ppEnabledExtensionNames = null,
	};

	let instance: vk::VkInstance = null;
	const res: vk::VkResult = vk::vkCreateInstance(&ci, null, &instance);
	if (res == vk::VkResult::VK_SUCCESS) {
		vk::load_instance(instance);
		return instance;
	} else {
		return res;
	};
};

export fn main() void = {
	match (create_instance("sample program\0", "No Engine\0", true)) {
		case let instance: vk::VkInstance =>
		     fmt::printfln("create_instance returned an instance: {}", instance)!;
		case let status: vk::VkResult =>
		     fmt::printfln("create_instance returned status {}", vk::StrVkResult(status))!;
	};
};
