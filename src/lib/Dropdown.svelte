<script lang="ts">
	import DropdownOption from './DropdownOption.svelte';

	//export let menuOptions: string[] = [];
	export let avatar: any;
	export let username: string;
	export let onClick: (num: number) => void;
	export let onEditProfile: () => void;
</script>

<div class="bg-[#2E2E2E] rounded-md drop-shadow-md absolute w-72 left-full -translate-x-72 p-4">
	<button
		class="flex items-center mb-4 border-b-[1px] border-neutral-600 hover:bg-neutral-600 hover:rounded-md p-2 transition-colors duration-100 w-full"
		on:click={onEditProfile}
	>
		<img src={avatar || "/profile.svg"} alt="Profile Icon" class="h-10 w-10 object-cover bg-white rounded-full mr-3" />
		<p class="font-semibold text-lg capitalize">{username}</p>
		<p class="text-sm text-emerald-300 flex-1 text-right">Edit Profile</p>
	</button>
	<DropdownOption label="Settings" showArrow icon="gear" onClick={() => onClick(0)} />
	<DropdownOption label="Help" showArrow icon="help" onClick={() => onClick(1)} />
	<DropdownOption label="Log Out" icon="sign-out" onClick={() => onClick(2)} />
</div>
